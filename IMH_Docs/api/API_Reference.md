API Reference
The Instant Medical History Data API lets you incorporate functions normally executed on the Instant Medical History website into your application or website. The lists below identify the different types of resources that you can access using the API. The API also supports operations to create, update, or delete many of these resources.

The reference explains how to use the API to perform all of these operations. The guide is organized by resource type. A resource represents a type of data used by Instant Medical History. This includes encounters, questionnaires, questions, answer choices, and reports. Resource types are represented as JSON objects. The reference also lists one or more supported operations (GET, POST, DELETE, etc.) for each resource type and explains how to use those operations in your application.

Resource Types
The API interacts with the following types of resources:

About
Appointments
ChiefComplaint
Cultures
Encounters
IMH
InterviewCursor
MedicalSpecialties
PatientAnswer
Patient
Provider
QuestionnaireQueue
Questionnaires
Question
Report
ReportTypes
Settings
SpecialtyQuestionnaires
TocQuestionnaires
Transmitter
About
For About resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /about	Retrieve the information about the API service.
Appointments
For Appointments resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/appointments	Gets the current list of patient appointments for the encounter.
update	PUT /encounters/{encounterId}/appointments	Updates the patient appointments for the encounter.The request parameters mirror HL-7 specification messages for an appointment. Refer to the HL-7 specification for detailed parameter descriptions. Please contact Primetime Medical Software for any questions about what to input for parameters to integrate properly with IMH questionnaires and reports.
ChiefComplaint
For ChiefComplaint resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/chiefcomplaint	Retrieve the patient's chief complaint for the encounter.
update	PUT /encounters/{encounterId}/chiefcomplaint	Updates the patient's chief complaint for the encounter.
Cultures
For Cultures resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /cultures	Gets a list of the cultures supported by Instant Medical History.
Encounters
For Encounters resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
remove	DELETE /encounters	Delete an encounter session with the interview engine.
list	GET /encounters	Get a list of resources available for an encounter id. Useful for checking if an encounterId is valid.
insert	POST /encounters	Creates a new encounter with the Instant Medical History interview engine.
IMH
For IMH resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET 	Return a list of API links that provide the operations that can be performed. Your application should usually start here and discover the URIs for invoking other methods. You can think of this URI as the root of information for the Instant Medical History Data API.
InterviewCursor
For InterviewCursor resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/interviewcursor	Retrieve the current location of the interview cursor. A return value of '0' means the interview is at the first question. A return value of '-1' means the interview has not been initialized. For example, if you try and move the cursor before doing a GET to get the first question, you will get back a '-1'. A interger value returned is the index of the current question of the interview.
update	PUT /encounters/{encounterId}/interviewcursor	Updates the location of the interview cursor. Valid operations are 'MoveNext' and 'MovePrev'.
MedicalSpecialties
For MedicalSpecialties resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /medicalspecialties	Gets a list of the medical specialties supported by Instant Medical History.
PatientAnswer
For PatientAnswer resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
update	PUT /encounters/{encounterId}/patientanswer/{questionId}	Update the patient's response to the current question for the encounter.
Patient
For Patient resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/patient	Retrieve the patient information for the encounter.
update	PUT /encounters/{encounterId}/patient	Updates the patient information for the encounter.
Provider
For Provider resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/provider	Retrieve the provider information for the encounter.
update	PUT /encounters/{encounterId}/provider	Updates the provider information for the encounter.
QuestionnaireQueue
For QuestionnaireQueue resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/questionnairequeue	Gets the current questionnaire queue for the encounter.
update	PUT /encounters/{encounterId}/questionnairequeue	Updates the questionnaire queue for the encounter.You can use the /questionnaires, /tocquestionnaires, or /specialtyquestionnaires resource to lookup questionnaires to add to the queue. Use the Id and Name returned in the response when accessing those resources to fill in the Id and Name for the items you are adding to the queue. Also, you can add items to the queue without an Id and just a Name (ex: headache). The API will lookup the Name(s) without an Id and validate them for you.The response will contain the updated queue. If any names were invalid, the queue returned will have the Id set to -1 for the invalid item(s) and your application will need to resolve the error.
Questionnaires
For Questionnaires resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/questionnaires GET /questionnaires	Get a list of questionnaires that match the lookup parameter. This resource is also accessible from the IMH home resource to allow you to lookup and validate questionnaire names without creating an encounter. See the 'Guides and Tutorials' section for details.
Question
For Question resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/question	Gets the current interview question that should be presented to the user for a response.
Report
For Report resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
create	POST /encounters/{encounterId}/report	Creates the report for the encounter.
ReportTypes
For ReportTypes resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /reporttypes	Gets a list of the report types supported by Instant Medical History.
Settings
For Settings resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/settings	Retrieve the settings for the encounter.
update	PUT /encounters/{encounterId}/settings	Updates the settings for the encounter.
SpecialtyQuestionnaires
For SpecialtyQuestionnaires resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/specialtyquestionnaires	Gets a list of the specialty questionnaires supported by the encounter.
TocQuestionnaires
For TocQuestionnaires resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
list	GET /encounters/{encounterId}/tocquestionnaires	Gets a list of the toc questionnaires supported by the encounter.
Transmitter
For Transmitter resource details, see the resource page.

Method	HTTP Request	Description
URIs relative to: https://www.ptimhservice.com/api/v2/imh
create	POST /encounters/{encounterId}/transmitter	Create a report and send it to the location specified in Address.
© 2014-2023 Primetime Medical Software, Inc.