# Symptra — App Spec

## Overview

Symptra is an iOS healthcare app that guides users through a dynamic medical questionnaire powered by the Instant Medical History (IMH) API.

Users:
1. Log in
2. Enter a symptom or health concern
3. Are guided through a branching questionnaire
4. Receive a structured medical report (HTML or PDF)
5. Can view past reports and sessions

The IMH API handles all questionnaire logic, branching, and report generation.

---

## Core Product Concept

Symptra is a **client interface to a dynamic medical interview engine**.

The app does NOT:
- determine questions
- control branching logic
- generate reports

The IMH API handles all of that.

The app DOES:
- collect user input
- display questions
- send answers
- follow API-provided links
- render results

---

## V1 Goals

- iOS app (SwiftUI)
- **Firebase in V1:** Firebase Authentication + Firebase Core + Cloud Firestore
- Login via Firebase (not a long-term stub)
- User **profile** with DOB and gender, saved at account creation and editable on a profile screen
- Start questionnaire from symptom input
- Fully dynamic questionnaire flow (API-driven)
- IMH API integration (discover links, no hardcoded paths)
- Report display (HTML/PDF) **in-app only** for V1 (no share/export requirement)
- **Session history** with ability to **resume an incomplete encounter**
- Clean, modular architecture

---

## V1 architecture & data (decisions)

### Firebase

- **Status (Symptra V1):** A Firebase project and Cloud Firestore database are **already created**; wire the iOS app with `GoogleService-Info.plist` from the Firebase Console (bundle ID must match the app).
- **Auth:** Identify the signed-in user; gate app content after login.
- **Firestore:** Persist user profile (including DOB and gender), session/encounter records, and whatever link or state blobs are required to **resume** an in-progress questionnaire after app relaunch.
- **Rules:** Apply least-privilege Firestore security rules; users may only read/write their own profile and sessions.
- **Do not** commit private keys, service accounts, or other secrets in source or docs.

### IMH API environment (V1)

- **Production only:** V1 targets a single IMH base URL (no separate sandbox URL in use).
- **IMH root (first request):** `https://www.ptimhservice.com/api/v2/imh` — used only as the **entry point** to GET the hypermedia root; all other paths must come from **APILinks** in responses (see `IMH_Docs/api/Guides.md` for examples).
- Optionally expose this as a build setting (e.g. `IMH_ROOT_URL`) so a future non-production host can be swapped without code changes.

### User profile vs encounter

- **DOB and gender** are collected when the user **creates an account** (or completes initial profile setup) and maintained on a **profile** screen.
- They are **not** re-collected every session; when starting or resuming an encounter, the app supplies patient info to the IMH API from the stored profile (IMH still requires DOB + gender for the encounter—source of truth for “what to send” is the profile).

### Session history and resume

- Persist enough **server and hypermedia state** per session to continue the interview: e.g. encounter identifier, completion flag, timestamps, symptom/concern text, and **current links or opaque state** returned by the API (exact shape TBD from IMH responses—design models to be extensible).
- **History UI** lists sessions; users can open **completed** sessions (reports) and **resume incomplete** ones.

### IMH API credentials (service account)

- IMH uses **HTTP Basic Auth** (API user + password) on **every** request.
- **Never** embed credentials in app source, committed config, or this spec.
- **Recommended for V1:** supply credentials via a **gitignored** Xcode build configuration (e.g. `Secrets.xcconfig`) with user-defined build settings (e.g. `IMH_API_USER`, `IMH_API_PASSWORD`), referenced only from the app target’s base configuration. Document in README that developers copy `Secrets.xcconfig.example` and fill locally.
- **Alternative:** one-time entry stored in **Keychain** (more suited if credentials vary per environment or per deploy).
- CI and teammates use their own secrets files or injected env vars; production builds use secure pipelines, not committed files.

### Reports (V1)

- Support **HTML and PDF** from the API **inside the app** (e.g. web view for HTML, PDF via system/PDFKit or Quick Look as appropriate).
- No requirement in V1 for share sheet, Files export, or email.

---

## Critical API Design Constraint (VERY IMPORTANT)

The IMH API follows a **HATEOAS (Hypermedia as the Engine of Application State)** design.

This means:
- The app must NOT hardcode endpoint paths
- The API response contains links ("APILinks") for next actions
- The app must follow links returned by the API

Example flow:
1. GET IMH root URL (see **IMH API environment**) → discover links
2. POST to encounters (via discovered link)
3. Use returned links to:
   - set patient
   - set provider
   - queue questionnaires
   - fetch questions
   - submit answers
   - generate report

This is NOT a traditional REST API with fixed endpoints.

---

## Core API Flow (Simplified)

### 1. Authentication (IMH)

- Use Basic Auth with API user + password (from secure configuration, not source code)
- Send `Authorization` on **every** IMH request
- See **IMH API credentials** under *V1 architecture & data* for storage practice

---

### 2. Start Session (Encounter)

Flow:
1. GET IMH root resource
2. Find link to "encounters"
3. POST → create encounter

---

### 3. Configure Encounter

Must do:

- PUT settings (enable question form mode + namespace)
- PUT patient info (DOB + gender REQUIRED)
- PUT provider info (optional but recommended)

---

### 4. Select Questionnaire

Options:
- Use symptom text (e.g. "headache")
- API maps this to questionnaire IDs

Example:
GET questionnaires?lookup=backache

Then:
POST questionnaire IDs → questionnaire queue

---

### 5. Question Loop

Loop:
1. GET current question
2. Display question + answer options
3. User selects answer
4. PUT answer to API
5. API advances cursor
6. Repeat until complete

The app must:
- handle unknown number of questions
- dynamically render UI based on question type

---

### 6. Completion

When no more questions:
- API indicates interview is complete
- App requests report

---

### 7. Report

- Generated via reports resource
- Formats:
  - HTML
  - PDF

App must support both

---

## Key Screens

### LoginView
- Firebase Authentication sign-in / sign-up flow aligned with profile creation (see Profile)

---

### ProfileView (or Profile section)

- Collect and edit **date of birth** and **gender** (required for IMH patient PUT; stored with the account)
- Persist to Firestore with the user’s profile

---

### DashboardView
- Start questionnaire
- View history

---

### StartQuestionnaireView
- User inputs symptom text
- Starts encounter + questionnaire flow

---

### QuestionnaireView (CRITICAL SCREEN)

Must support:
- dynamic questions
- unknown length
- multiple input types

UI types (start simple):
- single choice
- multiple choice
- text input
- yes/no

---

### ReportView
- Render HTML and PDF **in-app only** (V1)
- Show summary

---

### HistoryView
- List past sessions (complete and incomplete)
- Open reports for completed sessions
- **Resume** incomplete encounters using persisted session state

---

## Models (Conceptual)

```swift
Encounter
Question
Answer
Report
APILink
UserProfile        // Firebase uid, DOB, gender, etc.
SessionRecord      // Firestore: links/state for resume, completion, report refs
```

---

## Local API Documentation (IMPORTANT)

The project includes local copies of IMH API documentation and examples located in:

IMH_Docs/api/

These files may include:
- Question form structures
- Sample API responses
- Questionnaire examples
- API usage patterns

Examples:
- IMH_Docs/api/Question_Form_Samples.md
- IMH_Docs/api/Question_Forms.md
- IMH_Docs/api/Gettign_Started.md
- IMH_Docs/api/Guides.md

### How to Use These Docs

- Use these files as reference material when implementing:
  - question rendering
  - API response parsing
  - questionnaire flow
- Prefer these local docs over assumptions when modeling API responses
- If API structure is unclear, search these files before guessing

### Important Constraints

- Do NOT assume these docs are complete or final
- Do NOT hardcode logic based solely on examples
- Use them to guide flexible, extensible models
- Always design for variability in API responses

### Cursor Instruction

When implementing API-related features:
- Check IMH_Docs/api/ for examples before defining models
- Extract patterns, not rigid structures
- Ask questions if multiple interpretations are possible