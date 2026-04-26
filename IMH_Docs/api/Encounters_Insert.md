Encounters: insert

Creates a new encounter with the Instant Medical History interview engine.

Request
HTTP Request
POST https://www.ptimhservice.com/api/v2/imh/encounters

Query Parameters
There are no query parameters for this method.

Request Parameters
There are no request parameters for this method.

Example Request Structure
There is no body for this request.

Response
Response Properties
The following table defines the properties that appear in a response from this resource.

Property name	Value	Description
ApiStatus	ApiStatus	The status information resulting from the request.
ApiStatus.ApiStatusCode	integer	The error code from the API indicating the reason for the failure.
ApiStatus.ApiMessage	string	The error or status message from the API indicating details about the error.
ApiStatus.FWStatusCode	integer	The inner error code from the IMH framework. May provide more details for the cause of an error.
ApiStatus.FWMessage	string	The error or status message from the IMH framework indicating details about a framework error.
Encounter	Encounter	The encounter object contains the encounter id and methods for operating on the interview.
Encounter.EncounterId	string	The id for the current encounter.
Encounter.ApiLinks[]	list<ApiLink>	The methods available to operate on this resource. This includes methods to access the patient, provider, questionnaires, and questions for the encounter.
Encounter.ApiLinks[].ResourceName	string	The name of the resource.
Encounter.ApiLinks[].HttpMethods[]	list<String>	The HTTP methods supported by the resource.
Encounter.ApiLinks[].URL	string	The URL to access the resource.
Example Response Structure
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
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
{
    "ApiStatus" : {
        "ApiStatusCode" : 5000,
        "ApiMessage" : "OK",
        "FWStatusCode" : 0,
        "FWMessage" : ""
    },
    "Encounter" : {
        "EncounterId" : "",
        "ApiLinks" : [
            {
                "Title" : "Self",
                "Description" : "Self referencing api",
                "ResourceName" : "self",
                "HttpMethods" : [
                    "GET",
                    "DELETE"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters/"
            },
            {
                "Title" : "Encounter Provider",
                "Description" : "Operate on the provider for the interview.",
                "ResourceName" : "provider",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//provider"
            },
            {
                "Title" : "Encounter Patient",
                "Description" : "Operate on the patient for the interview.",
                "ResourceName" : "patient",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//patient"
            },
            {
                "Title" : "Patient Chief Complaint",
                "Description" : "Operate on the patient\u0027s chief complaint for the interview.",
                "ResourceName" : "chiefcomplaint",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//chiefcomplaint"
            },
            {
                "Title" : "Encounter Questionnaire Queue",
                "Description" : "The list of questionnaires to be processed during the interview.",
                "ResourceName" : "questionnairequeue",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//questionnairequeue"
            },
            {
                "Title" : "Encounter Questionnaires",
                "Description" : "Add questionnaires to the interview.",
                "ResourceName" : "questionnaires",
                "HttpMethods" : [
                    "GET"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//questionnaires"
            },
            {
                "Title" : "Specialty Questionnaires",
                "Description" : "Get the list specialty questionnaires.",
                "ResourceName" : "specialtyquestionnaires",
                "HttpMethods" : [
                    "GET"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//specialtyquestionnaires"
            },
            {
                "Title" : "TOC Questionnaires",
                "Description" : "Get the list of toc questionnaires.",
                "ResourceName" : "tocquestionnaires",
                "HttpMethods" : [
                    "GET"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//tocquestionnaires"
            },
            {
                "Title" : "Encounter Question",
                "Description" : "Get a question for the interview.",
                "ResourceName" : "question",
                "HttpMethods" : [
                    "GET"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//question"
            },
            {
                "Title" : "Interview Cursor",
                "Description" : "Cursor to indicate and move location in the interview.",
                "ResourceName" : "interviewcursor",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//interviewcursor"
            },
            {
                "Title" : "Settings",
                "Description" : "Operate on the settings for the interview.",
                "ResourceName" : "settings",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//settings"
            },
            {
                "Title" : "Create Report",
                "Description" : "Create a report from the interview data collected.",
                "ResourceName" : "report",
                "HttpMethods" : [
                    "POST"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//report"
            },
            {
                "Title" : "Transmit a Report",
                "Description" : "Create a report and transmit it.",
                "ResourceName" : "transmitter",
                "HttpMethods" : [
                    "POST"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//transmitter"
            },
            {
                "Title" : "Patient Appointments",
                "Description" : "The list of appointmemtns for the patient..",
                "ResourceName" : "appointments",
                "HttpMethods" : [
                    "GET",
                    "PUT"
                ],
                "URL" : "https://www.ptimhservice.com/api/v2/imh/encounters//appointments"
            }
        ]
    }
}
© 2014-2023 Primetime Medical Software, Inc.