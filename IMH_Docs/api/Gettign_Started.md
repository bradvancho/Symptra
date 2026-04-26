Getting Started
This page will help you get started with using the Instant Medical History (IMH) Data API.

What is Instant Medical History
Instant Medical History (IMH) gathers a complete present illness and past medical history before the office visit. Patients respond to multiple choice questions that branch based on their responses. In the background, the software translates the interview summary into clinical terminology and organizes the positives and negatives according to the pertinent organ system.

Enabling the patient to enter the data necessary to populate the subjective portion of the medical record makes the time spent in the visit more efficient and enhances communication. Both the patient and the doctor are focused on the health concerns presented at the start of the visit.

IMH contains thousands of complaints (cough, fever, headache, etc.) and hundreds of psychometric scales that can be accessed via the API. The knowledgebase contains tens of thousands of questions that these complaints access to perform a computerized patient interview.

What the Data API Does
The data API allows your application to access the IMH interview engine over internet. Your client application can create an encounter with IMH and queue questionnaires to be administered by the software. Finally, the report writer allows collecting the data in a variety of ways in many different file formats.

Your application accesses the resources of the API to perform its task. Examples of resources are "encounters", "reports", and "questionnaires". You initiate requests to these resources and IMH will process the requests and return appropriate responses. These resources provide a simple way for your application to provide patient interviews while hiding the complexity of the branching and the maintance of the huge knowledgebase of questionnaires.

The API provided is a very dynamic system. The implementation follows a "Hypermedia as the Engine of Application State" concept. This means that when you make a request to a resource, the response includes the paths (or links) to the URIs to perform operations on the resource. For example, if you make a request to the root resource ("IMH"), contained in the response is the path your application will use to create (via POST) an "encounter". This provides a lot of flexibility for the API to direct your application through the resources in the system and also add new functionality over time.

Setting Up an Account
In order to access the API, you will need to have an account created on the IMH system. To help you with creating an account, please contact us at: apisupport@medicalhistory.com

Creating API Keys
After your account is setup, you can signin and manage your API account. This includes creating keys that are required in order for your application to access the API. You need to create at least one key, but you can create additional keys if you want. This allows you to have different keys for development, staging, and production. You should also have different keys for each customer.

Next Steps
We recommend you read the "Guides and Tutorials" section next to get more details about using the API. After that, the "Reference" section goes into details about the functions provided by each of the resources in the system. You should review each endpoint in the Reference section to understand all the features available with the API.

References
The following are references to external documentation and information that you may find helpful.

A basic overview of Representational State Transfer (REST) is here: http://en.wikipedia.org/wiki/Representational_state_transfer
Definition of HATEOAS (Hypermedia as the Engine of Application State). Link http://en.wikipedia.org/wiki/HATEOAS
The book, "ASP.NET MVC 4 and the Web API: Building a REST Service from Start to Finish" is a great reference on RESTful implementations. You can access the book here: http://www.amazon.com/dp/1430249773
A good post about Web APIs and Security. Link http://jamiekurtz.com/2013/01/14/asp-net-web-api-security-basics/
Every developer writing web api services or clients needs Fiddler. Link http://fiddler2.com/