Guides and Tutorials
 

Overview
This page will help with writing your client application to access the data API. The sample code below is written in C#.

After reading the online documentation, you should schedule a meeting with the IMH team to get further training on using the IMH API. The IMH team is available to answer any questions you may have and guide you in proper use of the API.

The IMH team will need to review your application before it is used by patients to certify that the application has correctly implemented the interview process.

Other Guides
Question Forms

JSON Narrative Report Guide

Access the API
In order to access the IMH data API, you will need to sign in to your account. On your account page, following the link to "API Applications". This page allows you to create API application keys. You will use the API key in the HTTP Authorization header when making requests. The management of your API keys is under your control, so you can create keys for different customers or keys for development, production, etc. Also remember to always use "https://" to access the API.

Sample Basic Authentication Client Code
Below is sample C# code that shows how to setup the HTTP Authorization header with your API key and password. For brievity, other examples may not show adding the Authorization header. However, your application should set the Authorization header on every request.

?
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
// Create a new WebClient instance.
var webClient = new WebClient();
 
// Put the API key and password into a string. Do not use the GUID below. Get the 
// one from your API key.
const string creds = "00000000-57c4-4aa6-0000-4fb98b4c0a0b" + ":" + "password";
 
// Convert the credentials into a byte buffer.
var bcreds = Encoding.ASCII.GetBytes(creds);
 
// Convert the buffer to its equivalent string repesentation that is encoded with base-64 digits.
var base64Creds = Convert.ToBase64String(bcreds);
 
// Add the credentials to the request header.
webClient.Headers.Add("Authorization", "Basic " + base64Creds);
API Requests
When you make a request, it is usually either a HTTP GET or a HTTP POST/PUT.

A GET request will not have a body. Instead, you will pass parameters (if any) via query strings. For example, to lookup a questionnaire, your application would do something like:

http://www.ptimhservice.com/api/v2/imh/encounters/{encounteridhere}/questionnaires?lookup=headache

A POST/PUT request will usually have a body. You should refer to the Reference section of this documentation to understand the fields that go in the body of a POST/PUT request to the API.

API Responses
A request to the API will return a response. The response contains a status to indicate the success or failure of the request. The response can also contain "APILinks" that describe how to interact with the resource. Also, a response will sometimes echo back data that was sent in the request. For example, when updating the patient resource with their name, date of birth, etc., the data in the request is sent back as part of the response.

IMH Home Resource
The IMH resource is the starting place (home) for your application. You access the IMH resource with a request like the one below.

?
1
2
3
4
5
// Create a new WebClient instance. Remember to set the Authorization header (shown above).
var webClient = new WebClient();
 
// GET the IMH resource.
var content = webClient.DownloadString("https://www.ptimhservice.com/api/v2/imh");
The response contains the links that describe what resources are available from the data API. These resource include the encounters resource which allows you to create an encounter with the interview engine. Also, you can get the list of AMA medical specialties supported. Finally, the list of report types allowed can be retrieved.

You can view a sample response from this request here: IMH: list

Creating an Encounter
To run a patient interview, your application will need to create an encounter resource. Here is an example of how to do this.

?
1
2
3
4
5
6
7
8
9
10
11
12
13
14
// Create a new WebClient instance. Remember to set the Authorization header (shown above).
var webClient = new WebClient();
 
// GET the IMH resource.
var content = webClient.DownloadString("https://www.ptimhservice.com/api/v2/imh");
 
// Search the content in the IMH response for the API link to the "encounters" resource.
string encountersURI = CreateEncountersURI(content);
 
// POST to the encounters resource.
var response = webClient.UploadString(encountersURI, "POST", null);
 
// The response will contain APILinks to indicate the operations allowed 
// on the encounter resource that was created.
The encounters resource created will contain links to other resources you can use to operate on the encounter. These include setting the patient and provider information. There are resources to query and queue questionnaires to be administered. Finally, there are resource to create reports.

You can view a sample response from this request here: Encounters: insert

Encounter Settings
After you create an encounter, your application must perform a PUT to the "settings" resource that is under the encounters resource. The settings resource is used to turn on question form mode which is required to use a expanded question model for patient interview questions. There is also a Namespace.Root property in the settings that is used to indentify the correct questionnaires for a customer. The IMH team will provide the Namespace.Root string for you to use for each of your customers.

You can view the details on the settings resource here: Settings: update

Setting the Patient Information
After you create an encounter, your application must set (PUT) the "patient" resource that is under the encounters resource. The patient resource allows you to set the patient name, date of birth, gender, ID, etc. The patient date of birth and gender are required fields and must be set before adding questionnaires to the queue or processing interview questions.

You can view the details on the patient resource here: Patient: update

Setting the Provider Information
Similar to the patient resource, your application should set (PUT) to the provider resource also. The provider resource allows you to set the provider name, location, etc. Also, you can set the provider medical specialty. The provider's specialty is used when accessing Specialty Questionnaires (see below).

You can view the details on the patient resource here: Provider: update

Selecting Questionnaires and the Questionnaire Queue
After setting up the patient and provider resources, your application will need to tell the interview engine which questionnaires to administer. Your application can lookup a questionnaire in several ways. These include using the Questionnaires resource, the Specialty Questionnaires resource, and the Table of Contents resource. Each of these methods return a questionnaire id that you then add to the Questionnaire Queue resource. You can also put questionnaire names (ex: cough, headache) into the Questionnaire Queue resource without the id. When you send the request to the API, it will validate all the names you put in and if they are all valid add them to the queue to be administered.

Questionnaires
The questionnaires resource provides a simple lookup for a complaint, screening, or scale via a GET to the resource with the lookup phrase specified as a query string parameter. For example:

GET .../encounters/.../questionnaires?lookup=I have a cough and a fever

will return a response that contains information (ids) for the cough and the fever questionnaires.

You can also access the questionnaires resource without creating an encounter. When you GET .../imh (the home resource), there is an ApiLink in the response to a questionnaires resource that can be used without an encounter id. Here is an example of using the resource in this manner:

GET ../imh/questionnaire/?lookup=backache

If the lookup phrase is not found, the ApiStatus message will contain a message indicating the phrase that was not found instead of the usual "OK".

The questionnaires resource contains a large collection of phrases along with common misspellings that will provide a valid response to just about any complaint string (ex: backache, backacke, bee string, etc.) Your application can implement an input phrase textbox and let the patient enter a short phrase of their complaints. Another option is to implement your own pick list of complaints and pass the complaint string to this resource to lookup the questionnaire ids to POST to the questionnaire queue to start the interview process.

You can view the details on the this resource here: Questionnaires: list

Specialty Questionnaires
The specialty questionnaire resource returns a list of questionnaires based on a medical specialty lookup key. You can pass one or more AMA specialty abbreviations (C=Cardiology, D=Dermotology, etc.) as a parameter to the GET request on this resource and the response will contain the most common questionnaires for that specialty. If you set the specialty for the provider resource previously, you can call the specialty questionnaire resource and it will return the questionnaire list for the provider.

You can view the details on the this resource here: Specialty Questionnaires: list

Table of Contents Questionnaires
The table of contents resource returns a hierarchical collection of complaints. Your application can display this list and allow the patient or healthcare provider to select the questionnaire they would like to run. The table of contents accepts a parameter to return either the nurse/doctor table of contents or the patient table of contents. Each collection returns a similar hierachical structure, the difference being the terminology used being more appropriate for the specified reader.

Questionnaire Queue
Each of the methods of above will contain a questionnaire id in the response. Your application should then put one or more of the ids into the request to the questionnaire queue resource. The GET, POST, and DELETE verbs can all be applied to the queue resource. This provides you with a complete set of ways to manipulate the queue and control what questionnaires will be asked to the patient.

You can view the details on the this resource here: Questionnaires Queue: update

Processing Questions
After configuring the questionnaire queue resource, your application is ready to start retrieving questions for the user to answer.

Your application can perform a GET to the question resource to retrieve the current question for the interview. Then, display the question text and the answer choices to the user. After collecting the patient's answer, you will POST that back to the service to record the patient's answer choice. There is an option in the request when you send the patient's answer choice to also move the interview cursor to the next question. This allows your application to retrieve the next question and continue this loop until the service responds that there are no more questions in the interview.

Here is an example of how to GET the current question in the interview

?
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
// Create a new WebClient instance. Remember to set the Authorization header (shown above).
var webClient = new WebClient();
 
// GET the IMH resource.
var content = webClient.DownloadString("https://www.ptimhservice.com/api/v2/imh");
 
// POST to the encounters resource to create an encounter.
// PUT the patient resource to set the patient information.
// PUT the provider resource to setup the provider.
// GET the questionnaires resource to lookup a questionnaire.
// POST the questionnaire id to the questionnairequeue resource.
 
// Now get the current question. The URI will look like the string below. Remember to 
// dynamically discover the URI via the APILinks returned from the encounters resource.
content = webClient.DownloadString("https://www.ptimhservice.com/api/v2/imh/encounters/{encounterid}/question");
 
// The content returned will be a question resource response 
// that contains the question text and answer choices.
//
// Display the question and wait on the patient response.
//
You can view the details on the this resource here: Question: list

After you collect the patient's answer selection, you can PUT that data to the API like this:

?
1
2
3
4
5
6
7
8
9
10
// Create a patientanswer request with the answer id the patient selected in it.
var patientAnswerRequest = CreatePatientAnswerRequest(....);
 
// The URI shown below is just an example, remember to dynamically get the path
// from the APILinks in the response from the encounters resource.
var response = webClient.UploadString(
    "https://www.ptimhservice.com/api/v2/imh/encounters/Q2KwBYWLz0O24_4OHrOaFA/patientanswer/27984", "PUT", patientAnswerRequest);
 
// If the response indicates no more questions, then the interview is done.
// Otherwise, you can do a GET on the question resource to get the next question.
You can view the details on the this resource here: PatientAnswer: update

Creating Reports
The reports resource is used to create interview reports. There are a rich set of options that can be set when creating a report. These allow your application to control options for the terminology used in the report, which responses should be included, and the file format to use in the report returned.

You can view the details on the patient resource here: Report: create