QuestionForm Samples
Overview
Below are a variety of QuestionForm samples. Each sample lists the questionnaire name used to access the question. There is also a description that helps understand what the sample does. A HTML rendering of the QuestionForm object is also displayed. The HTML form displayed gives one way of displaying the QuestionForm. Depending on your requirements, your application can display and style the form differently. Finally, each sample has a "Show JSON" link you can click to view the QuestionForm JSON object used to create the form.

QuestionFormSample-1
Questionnaire
QuestionFormSample-1
Description
This sample demonstrates a simple question with Yes/No answer choices.
 
Have you ever had heart surgery?
Yes
No
 
Hide JSON
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
{
    "Text" : "Have you ever had heart surgery?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-0",
                    "IMH-Answer-1"
                ]
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "LabelMap" : {
                    "IMH-Answer-0" : "Yes",
                    "IMH-Answer-1" : "No"
                }
            }
        ]
    }
}
Hide JSON
QuestionFormSample-2
Questionnaire
QuestionFormSample-2
Description
This sample demonstrates a question with several answers. Only one answer choice is allowed (single-choice)
 
Who is providing the information for this questionnaire?
Self
Spouse
Significant other
Parent
Daughter or son
Sibling
Family member
Friend
Interpreter
Other
 
Hide JSON
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
{
    "Text" : "Who is providing the information for this questionnaire?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-0",
                    "IMH-Answer-1",
                    "IMH-Answer-2",
                    "IMH-Answer-3",
                    "IMH-Answer-4",
                    "IMH-Answer-5",
                    "IMH-Answer-6",
                    "IMH-Answer-7",
                    "IMH-Answer-8",
                    "IMH-Answer-9"
                ]
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "LabelMap" : {
                    "IMH-Answer-0" : "Self",
                    "IMH-Answer-1" : "Spouse",
                    "IMH-Answer-2" : "Significant other",
                    "IMH-Answer-3" : "Parent",
                    "IMH-Answer-4" : "Daughter or son",
                    "IMH-Answer-5" : "Sibling",
                    "IMH-Answer-6" : "Family member",
                    "IMH-Answer-7" : "Friend",
                    "IMH-Answer-8" : "Interpreter",
                    "IMH-Answer-9" : "Other"
                }
            }
        ]
    }
}
Hide JSON
QuestionFormSample-3
Questionnaire
QuestionFormSample-3
Description
This sample demonstrates a question with a lot of answer choices. Only one answer choice is allowed. Since the list of states contains 50 answer choices, this would be a lot of radio buttons to put on the screen. Referring to the JSON source, you will see a "FormatTypeHint": "single-select-list" in the variable layout. This is a hint that your UI should consider putting the answer choices into a listbox. Technically, you can also design your rendering for the previous two samples to also put the answer choices into a list instead of using radio buttons. That choice is up to you.
 
What state do you live in?
State
Alabama
 
Hide JSON
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
{
    "Text" : "What state do you live in?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "Enum" : [
                    "IMH-Answer-0",
                    "IMH-Answer-1",
                    "IMH-Answer-2",
                    "IMH-Answer-3",
                    "IMH-Answer-4",
                    "IMH-Answer-5",
                    "IMH-Answer-6",
                    "IMH-Answer-7",
                    "IMH-Answer-8",
                    "IMH-Answer-9",
                    "IMH-Answer-10",
                    "IMH-Answer-11",
                    "IMH-Answer-12",
                    "IMH-Answer-13",
                    "IMH-Answer-14",
                    "IMH-Answer-15",
                    "IMH-Answer-16",
                    "IMH-Answer-17",
                    "IMH-Answer-18",
                    "IMH-Answer-19",
                    "IMH-Answer-20",
                    "IMH-Answer-21",
                    "IMH-Answer-22",
                    "IMH-Answer-23",
                    "IMH-Answer-24",
                    "IMH-Answer-25",
                    "IMH-Answer-26",
                    "IMH-Answer-27",
                    "IMH-Answer-28",
                    "IMH-Answer-29",
                    "IMH-Answer-30",
                    "IMH-Answer-31",
                    "IMH-Answer-32",
                    "IMH-Answer-33",
                    "IMH-Answer-34",
                    "IMH-Answer-35",
                    "IMH-Answer-36",
                    "IMH-Answer-37",
                    "IMH-Answer-38",
                    "IMH-Answer-39",
                    "IMH-Answer-40",
                    "IMH-Answer-41",
                    "IMH-Answer-42",
                    "IMH-Answer-43",
                    "IMH-Answer-44",
                    "IMH-Answer-45",
                    "IMH-Answer-46",
                    "IMH-Answer-47",
                    "IMH-Answer-48",
                    "IMH-Answer-49",
                    "IMH-Answer-50"
                ]
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "State",
                "LabelMap" : {
                    "IMH-Answer-0" : "Alabama",
                    "IMH-Answer-1" : "Alaska",
                    "IMH-Answer-2" : "Arizona",
                    "IMH-Answer-3" : "Arkansas",
                    "IMH-Answer-4" : "California",
                    "IMH-Answer-5" : "Colorado",
                    "IMH-Answer-6" : "Connecticut",
                    "IMH-Answer-7" : "Delaware",
                    "IMH-Answer-8" : "District of Columbia",
                    "IMH-Answer-9" : "Florida",
                    "IMH-Answer-10" : "Georgia",
                    "IMH-Answer-11" : "Hawaii",
                    "IMH-Answer-12" : "Idaho",
                    "IMH-Answer-13" : "Illinois",
                    "IMH-Answer-14" : "Indiana",
                    "IMH-Answer-15" : "Iowa",
                    "IMH-Answer-16" : "Kansas",
                    "IMH-Answer-17" : "Kentucky",
                    "IMH-Answer-18" : "Louisiana",
                    "IMH-Answer-19" : "Maine",
                    "IMH-Answer-20" : "Maryland",
                    "IMH-Answer-21" : "Massachusetts",
                    "IMH-Answer-22" : "Michigan",
                    "IMH-Answer-23" : "Minnesota",
                    "IMH-Answer-24" : "Mississippi",
                    "IMH-Answer-25" : "Missouri",
                    "IMH-Answer-26" : "Montana",
                    "IMH-Answer-27" : "Nebraska",
                    "IMH-Answer-28" : "Nevada",
                    "IMH-Answer-29" : "New Hampshire",
                    "IMH-Answer-30" : "New Jersey",
                    "IMH-Answer-31" : "New Mexico",
                    "IMH-Answer-32" : "New York",
                    "IMH-Answer-33" : "North Carolina",
                    "IMH-Answer-34" : "North Dakota",
                    "IMH-Answer-35" : "Ohio",
                    "IMH-Answer-36" : "Oklahoma",
                    "IMH-Answer-37" : "Oregon",
                    "IMH-Answer-38" : "Pennsylvania",
                    "IMH-Answer-39" : "Rhode Island",
                    "IMH-Answer-40" : "South Carolina",
                    "IMH-Answer-41" : "South Dakota",
                    "IMH-Answer-42" : "Tennessee",
                    "IMH-Answer-43" : "Texas",
                    "IMH-Answer-44" : "Utah",
                    "IMH-Answer-45" : "Vermont",
                    "IMH-Answer-46" : "Virginia",
                    "IMH-Answer-47" : "Washington",
                    "IMH-Answer-48" : "West Virginia",
                    "IMH-Answer-49" : "Wisconsin",
                    "IMH-Answer-50" : "Wyoming"
                },
                "FormatTypeHint" : "single-select-list"
            }
        ]
    }
}
Hide JSON
QuestionFormSample-4
Questionnaire
QuestionFormSample-4
Description
This sample demonstrates a simple question with several checkbox answers. The user can select as many answer choices as needed.
 
Do you use any devices to help you to walk?
Cane
Crutches
Walker
Wheelchair
Scooter
 
Hide JSON
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
{
    "Text" : "Do you use any devices to help you to walk?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "bool",
                "Required" : false
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-1"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-2"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-3"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-4"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Cane"
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Label" : "Crutches"
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Label" : "Walker"
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Label" : "Wheelchair"
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Label" : "Scooter"
            }
        ]
    }
}
Hide JSON
QuestionFormSample-5
Questionnaire
QuestionFormSample-5
Description
This sample demonstrates a question with a lot of checkbox (bool) answer choices.The JSON structure for this question uses a grid form layout to indicate the answers can be displayed in 6 rows with 3 columns.
 
What tends to make your back or leg (sciatic) pain worse?
Bending
Squatting
Twisting
Lifting
Sitting
Standing
Walking
Kneeling
Crawling
Leaning
Activity
Work
Laying down
Stress
Cough/sneeze
Bowel movement
 
Hide JSON
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
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
{
    "Text" : "What tends to make your back or leg (sciatic) pain worse?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-6",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-7",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-8",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-9",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-10",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-11",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-12",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-13",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-14",
                "Type" : "bool",
                "Required" : false
            },
            {
                "VariableName" : "IMH-Variable-15",
                "Type" : "bool",
                "Required" : false
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "grid",
                "GridBody" : [
                    [
                        "IMH-Variable-0",
                        "IMH-Variable-1",
                        "IMH-Variable-2"
                    ],
                    [
                        "IMH-Variable-3",
                        "IMH-Variable-4",
                        "IMH-Variable-5"
                    ],
                    [
                        "IMH-Variable-6",
                        "IMH-Variable-7",
                        "IMH-Variable-8"
                    ],
                    [
                        "IMH-Variable-9",
                        "IMH-Variable-10",
                        "IMH-Variable-11"
                    ],
                    [
                        "IMH-Variable-12",
                        "IMH-Variable-13",
                        "IMH-Variable-14"
                    ],
                    [
                        "IMH-Variable-15",
                        "",
                        ""
                    ]
                ]
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Bending"
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Label" : "Squatting"
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Label" : "Twisting"
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Label" : "Lifting"
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Label" : "Sitting"
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Label" : "Standing"
            },
            {
                "VariableName" : "IMH-Variable-6",
                "Label" : "Walking"
            },
            {
                "VariableName" : "IMH-Variable-7",
                "Label" : "Kneeling"
            },
            {
                "VariableName" : "IMH-Variable-8",
                "Label" : "Crawling"
            },
            {
                "VariableName" : "IMH-Variable-9",
                "Label" : "Leaning"
            },
            {
                "VariableName" : "IMH-Variable-10",
                "Label" : "Activity"
            },
            {
                "VariableName" : "IMH-Variable-11",
                "Label" : "Work"
            },
            {
                "VariableName" : "IMH-Variable-12",
                "Label" : "Laying down"
            },
            {
                "VariableName" : "IMH-Variable-13",
                "Label" : "Stress"
            },
            {
                "VariableName" : "IMH-Variable-14",
                "Label" : "Cough/sneeze"
            },
            {
                "VariableName" : "IMH-Variable-15",
                "Label" : "Bowel movement"
            }
        ]
    }
}
Hide JSON
QuestionFormSample-6
Questionnaire
QuestionFormSample-6
Description
This sample demonstrates a question with a single text input. There is also a field in the JSON called "MaxLength" that is used to limit the number of characters that can be entered.
 
What is your occupation?
Occupation
ex: school teacher
 
Hide JSON
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
{
    "Text" : "What is your occupation?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Occupation",
                "Placeholder" : "ex: school teacher"
            }
        ]
    }
}
Hide JSON
QuestionFormSample-7
Questionnaire
QuestionFormSample-7
Description
This sample demonstrates a question with a multi-line text input.The field "FormatTypeHint": "multi-line-text" is what indicates the text input should be an HTML <textarea> or equivalent.
 
Do you have any additional comments or concerns about your surgery?
Comments
 
Hide JSON
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
{
    "Text" : "Do you have any additional comments or concerns about your surgery?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 500
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Comments",
                "FormatTypeHint" : "multi-line-text"
            }
        ]
    }
}
Hide JSON
QuestionFormSample-8
Questionnaire
QuestionFormSample-8
Description
This sample demonstrates a question with several inputs. In addition to the question having multiple text inputs, it also demonstrates the "Subtype" and "WidthHint" fields. The "Subtype" for the telephone numbers is set to "phone-number". If you are rendering to HTML you can then set the type to "tel" to take advantage of the built-in HTML type for telephone numbers. Likewise, you can set the type to "email" for the "Subtype" of "email-address". The layouts for these variables also contain a width hint that you can take advantage of to control the width of the input form element. This allows the display to not have really wide fields when the user may only enter a few characters.
 
How can we contact you?
Home phone
ex: 212-555-1234
Cell phone
ex: 212-555-1212
E-mail address
 
Hide JSON
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
{
    "Text" : "How can we contact you?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Subtype" : "phone-number",
                "Required" : false,
                "MaxLength" : 25
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Subtype" : "phone-number",
                "Required" : false,
                "MaxLength" : 25
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Subtype" : "email-address",
                "Required" : false,
                "MaxLength" : 254
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-1"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-2"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Home phone",
                "Placeholder" : "ex: 212-555-1234",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Label" : "Cell phone",
                "Placeholder" : "ex: 212-555-1212",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Label" : "E-mail address",
                "WidthHint" : 30
            }
        ]
    }
}
Hide JSON
QuestionFormSample-9
Questionnaire
QuestionFormSample-9
Description
This sample demonstrates a question with an integer input. Additionally, the input value has to be within the range specified by "Maximum" and "Minimum". The rendering below using an HTML input with the type set to "number".
 
How many cigarettes per day do you smoke?
Cigarettes per day
 
Hide JSON
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
{
    "Text" : "How many cigarettes per day do you smoke?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "integer",
                "Required" : false,
                "Maximum" : 100,
                "Minimum" : 0,
                "MaxLength" : 10
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Cigarettes per day",
                "WidthHint" : 10
            }
        ]
    }
}
Hide JSON
QuestionFormSample-10
Questionnaire
QuestionFormSample-10
Description
This sample demonstrates a question with several integer inputs.
 
On a scale of 0 (no pain) to 10 (highest), what is your level of back pain?
Current pain
Average pain
Lowest pain in the past 24 hours
Highest pain in the past 24 hours
 
Hide JSON
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
{
    "Text" : "On a scale of 0 (no pain) to 10 (highest), what is your level of back pain?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "integer",
                "Required" : false,
                "Maximum" : 10,
                "Minimum" : 0,
                "MaxLength" : 10
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "integer",
                "Required" : false,
                "Maximum" : 10,
                "Minimum" : 0,
                "MaxLength" : 10
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "integer",
                "Required" : false,
                "Maximum" : 10,
                "Minimum" : 0,
                "MaxLength" : 10
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "integer",
                "Required" : false,
                "Maximum" : 10,
                "Minimum" : 0,
                "MaxLength" : 10
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-1"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-2"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-3"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Current pain",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Label" : "Average pain",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Label" : "Lowest pain in the past 24 hours",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Label" : "Highest pain in the past 24 hours",
                "WidthHint" : 10
            }
        ]
    }
}
Hide JSON
QuestionFormSample-11
Questionnaire
QuestionFormSample-11
Description
This sample demonstrates a question with a date input.
 
The interview that you selected does not have any questions that are appropriate for your birth sex or age. Please try a different questionnaire.
OK
 
Hide JSON
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
{
    "Text" : "The interview that you selected does not have any questions that are appropriate for your birth sex or age. Please try a different questionnaire.",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-0"
                ]
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "LabelMap" : {
                    "IMH-Answer-0" : "OK"
                }
            }
        ]
    }
}
Hide JSON
QuestionFormSample-12
Questionnaire
QuestionFormSample-12
Description
This sample demonstrates a question with several time inputs.
 
Please describe your meal pattern by entering the times you eat. If you do not know a time, just leave that item blank.
Breakfast
--:-- --
Morning snack
--:-- --
Lunch
--:-- --
Afternoon snack
--:-- --
Dinner
--:-- --
Night-time snack
--:-- --
 
Hide JSON
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
{
    "Text" : "Please describe your meal pattern by entering the times you eat. If you do not know a time, just leave that item blank.",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Subtype" : "time",
                "Required" : false,
                "MaxLength" : 30
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Subtype" : "time",
                "Required" : false,
                "MaxLength" : 30
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Subtype" : "time",
                "Required" : false,
                "MaxLength" : 30
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "string",
                "Subtype" : "time",
                "Required" : false,
                "MaxLength" : 30
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "string",
                "Subtype" : "time",
                "Required" : false,
                "MaxLength" : 30
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Type" : "string",
                "Subtype" : "time",
                "Required" : false,
                "MaxLength" : 30
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-0"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-1"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-2"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-3"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-4"
            },
            {
                "Type" : "variable",
                "VariableName" : "IMH-Variable-5"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Breakfast",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Label" : "Morning snack",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Label" : "Lunch",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Label" : "Afternoon snack",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Label" : "Dinner",
                "WidthHint" : 10
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Label" : "Night-time snack",
                "WidthHint" : 10
            }
        ]
    }
}
Hide JSON
QuestionFormSample-13
Questionnaire
QuestionFormSample-13
Description
This sample demonstrates a question with two groups of inputs. The layout has the variables divided into a group for the first contact and a group for the second contact. This sample renders the group using an HTML fieldset element.
 
Who can we contact on the day of surgery about your condition?
Contact #1
Contact name
ex: John Smith
Relationship
ex: spouse
Phone number
ex: 888-555-0000
Contact #2
Contact name
Relationship
Phone number
 
Hide JSON
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
{
    "Text" : "Who can we contact on the day of surgery about your condition?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50,
                "DisplayName" : "Contact name"
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 30
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Subtype" : "phone-number",
                "Required" : false,
                "MaxLength" : 50,
                "DisplayName" : "Phone number"
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Type" : "string",
                "Subtype" : "phone-number",
                "Required" : false,
                "MaxLength" : 50
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "group",
                "VariableNames" : [
                    "IMH-Variable-0",
                    "IMH-Variable-1",
                    "IMH-Variable-2"
                ],
                "GroupDisplayName" : "Contact #1"
            },
            {
                "Type" : "group",
                "VariableNames" : [
                    "IMH-Variable-3",
                    "IMH-Variable-4",
                    "IMH-Variable-5"
                ],
                "GroupDisplayName" : "Contact #2"
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Label" : "Contact name",
                "Placeholder" : "ex: John Smith"
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Label" : "Relationship",
                "Placeholder" : "ex: spouse"
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Label" : "Phone number",
                "Placeholder" : "ex: 888-555-0000",
                "WidthHint" : 20
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Label" : "Contact name"
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Label" : "Relationship"
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Label" : "Phone number",
                "WidthHint" : 20
            }
        ]
    }
}
Hide JSON
QuestionFormSample-14
Questionnaire
QuestionFormSample-14
Description
This sample demonstrates a question with a grid. The grid also contains row and column headers.
 
List all the medications you have been taking within the last two weeks (including the ones taken on 'as needed' basis).
Medication	Dose	Route	Directions	Purpose
Medication #1	
ex: zantac
ex: 150 mg
ex: oral
ex: 2x a day
ex: acid reflux
Medication #2	
Medication #3	
Medication #4	
Medication #5	
 
Hide JSON
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
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
{
    "Text" : "List all the medications you have been taking within the last two weeks (including the ones taken on 'asneeded' basis).",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-6",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-7",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-8",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-9",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-10",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-11",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-12",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-13",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-14",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-15",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-16",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-17",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-18",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-19",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-20",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-21",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-22",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-23",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-24",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "grid",
                "GridColHeaders" : [
                    "",
                    "Medication",
                    "Dose",
                    "Route",
                    "Directions",
                    "Purpose"
                ],
                "GridRowHeaders" : [
                    "Medication #1",
                    "Medication #2",
                    "Medication #3",
                    "Medication #4",
                    "Medication #5"
                ],
                "GridBody" : [
                    [
                        "IMH-Variable-0",
                        "IMH-Variable-1",
                        "IMH-Variable-2",
                        "IMH-Variable-3",
                        "IMH-Variable-4"
                    ],
                    [
                        "IMH-Variable-5",
                        "IMH-Variable-6",
                        "IMH-Variable-7",
                        "IMH-Variable-8",
                        "IMH-Variable-9"
                    ],
                    [
                        "IMH-Variable-10",
                        "IMH-Variable-11",
                        "IMH-Variable-12",
                        "IMH-Variable-13",
                        "IMH-Variable-14"
                    ],
                    [
                        "IMH-Variable-15",
                        "IMH-Variable-16",
                        "IMH-Variable-17",
                        "IMH-Variable-18",
                        "IMH-Variable-19"
                    ],
                    [
                        "IMH-Variable-20",
                        "IMH-Variable-21",
                        "IMH-Variable-22",
                        "IMH-Variable-23",
                        "IMH-Variable-24"
                    ]
                ]
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Placeholder" : "ex: zantac",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Placeholder" : "ex: 150 mg",
                "WidthHint" : 9
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Placeholder" : "ex: oral",
                "WidthHint" : 8
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Placeholder" : "ex: 2x a day",
                "WidthHint" : 16
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Placeholder" : "ex: acid reflux",
                "WidthHint" : 18
            },
            {
                "VariableName" : "IMH-Variable-5",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-6",
                "WidthHint" : 9
            },
            {
                "VariableName" : "IMH-Variable-7",
                "WidthHint" : 8
            },
            {
                "VariableName" : "IMH-Variable-8",
                "WidthHint" : 16
            },
            {
                "VariableName" : "IMH-Variable-9",
                "WidthHint" : 18
            },
            {
                "VariableName" : "IMH-Variable-10",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-11",
                "WidthHint" : 9
            },
            {
                "VariableName" : "IMH-Variable-12",
                "WidthHint" : 8
            },
            {
                "VariableName" : "IMH-Variable-13",
                "WidthHint" : 16
            },
            {
                "VariableName" : "IMH-Variable-14",
                "WidthHint" : 18
            },
            {
                "VariableName" : "IMH-Variable-15",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-16",
                "WidthHint" : 9
            },
            {
                "VariableName" : "IMH-Variable-17",
                "WidthHint" : 8
            },
            {
                "VariableName" : "IMH-Variable-18",
                "WidthHint" : 16
            },
            {
                "VariableName" : "IMH-Variable-19",
                "WidthHint" : 18
            },
            {
                "VariableName" : "IMH-Variable-20",
                "WidthHint" : 15
            },
            {
                "VariableName" : "IMH-Variable-21",
                "WidthHint" : 9
            },
            {
                "VariableName" : "IMH-Variable-22",
                "WidthHint" : 8
            },
            {
                "VariableName" : "IMH-Variable-23",
                "WidthHint" : 16
            },
            {
                "VariableName" : "IMH-Variable-24",
                "WidthHint" : 18
            }
        ]
    }
}
Hide JSON
QuestionFormSample-15
Questionnaire
QuestionFormSample-15
Description
This sample demonstrates a question with a grid. The grid contains row and column headers. Additionally, the column headers are present for the first column.
 
What are your expenses for the following?
Expenses	Amount/month
Rent, maintenance fee	
Water rate	
Sauna fee	
Electric, gas, oil fee	
 
Hide JSON
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
{
    "Text" : "What are your expenses for the following?",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 15
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 15
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 15
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 15
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "grid",
                "GridColHeaders" : [
                    "Expenses",
                    "Amount/month"
                ],
                "GridRowHeaders" : [
                    "Rent, maintenance fee",
                    "Water rate",
                    "Sauna fee",
                    "Electric, gas, oil fee"
                ],
                "GridBody" : [
                    [
                        "IMH-Variable-0"
                    ],
                    [
                        "IMH-Variable-1"
                    ],
                    [
                        "IMH-Variable-2"
                    ],
                    [
                        "IMH-Variable-3"
                    ]
                ]
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "WidthHint" : 20
            },
            {
                "VariableName" : "IMH-Variable-1",
                "WidthHint" : 20
            },
            {
                "VariableName" : "IMH-Variable-2",
                "WidthHint" : 20
            },
            {
                "VariableName" : "IMH-Variable-3",
                "WidthHint" : 20
            }
        ]
    }
}
Hide JSON
QuestionFormSample-16
Questionnaire
QuestionFormSample-16
Description
This sample demonstrates a question with a grid. The grid only contains column headers.
 
List each medication you are allergic to and the reaction you experienced.
Medication allergic to	Reaction
 
Hide JSON
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
{
    "Text" : "List each medication you are allergic to and the reaction you experienced.",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-6",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-7",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-8",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            },
            {
                "VariableName" : "IMH-Variable-9",
                "Type" : "string",
                "Required" : false,
                "MaxLength" : 50
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "grid",
                "GridColHeaders" : [
                    "Medication allergic to",
                    "Reaction"
                ],
                "GridBody" : [
                    [
                        "IMH-Variable-0",
                        "IMH-Variable-1"
                    ],
                    [
                        "IMH-Variable-2",
                        "IMH-Variable-3"
                    ],
                    [
                        "IMH-Variable-4",
                        "IMH-Variable-5"
                    ],
                    [
                        "IMH-Variable-6",
                        "IMH-Variable-7"
                    ],
                    [
                        "IMH-Variable-8",
                        "IMH-Variable-9"
                    ]
                ]
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0"
            },
            {
                "VariableName" : "IMH-Variable-1"
            },
            {
                "VariableName" : "IMH-Variable-2"
            },
            {
                "VariableName" : "IMH-Variable-3"
            },
            {
                "VariableName" : "IMH-Variable-4"
            },
            {
                "VariableName" : "IMH-Variable-5"
            },
            {
                "VariableName" : "IMH-Variable-6"
            },
            {
                "VariableName" : "IMH-Variable-7"
            },
            {
                "VariableName" : "IMH-Variable-8"
            },
            {
                "VariableName" : "IMH-Variable-9"
            }
        ]
    }
}
Hide JSON
QuestionFormSample-17
Questionnaire
QuestionFormSample-17
Description
This sample demonstrates a question with a grid. The grid only contains row headers. Also, you should note the hint to layout the answer choices horizontally. This makes the symptoms and the Yes/No response easier to read.
 
Have you ever been treated for any of the following problems
Asthma	YesNo
Diabetes	YesNo
Stroke	YesNo
Heart attack	YesNo
Emphysema	YesNo
Sleep apnea	YesNo
 
Hide JSON
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
{
    "Text" : "Have you ever been treated for any of the following problems",
    "Model" : {
        "Variables" : [
            {
                "VariableName" : "IMH-Variable-0",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-0",
                    "IMH-Answer-1"
                ]
            },
            {
                "VariableName" : "IMH-Variable-1",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-2",
                    "IMH-Answer-3"
                ]
            },
            {
                "VariableName" : "IMH-Variable-2",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-4",
                    "IMH-Answer-5"
                ]
            },
            {
                "VariableName" : "IMH-Variable-3",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-6",
                    "IMH-Answer-7"
                ]
            },
            {
                "VariableName" : "IMH-Variable-4",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-8",
                    "IMH-Answer-9"
                ]
            },
            {
                "VariableName" : "IMH-Variable-5",
                "Type" : "string",
                "Required" : true,
                "Enum" : [
                    "IMH-Answer-10",
                    "IMH-Answer-11"
                ]
            }
        ]
    },
    "Form" : {
        "FormLayoutItems" : [
            {
                "Type" : "grid",
                "GridRowHeaders" : [
                    "Asthma",
                    "Diabetes",
                    "Stroke",
                    "Heart attack",
                    "Emphysema",
                    "Sleep apnea"
                ],
                "GridBody" : [
                    [
                        "IMH-Variable-0"
                    ],
                    [
                        "IMH-Variable-1"
                    ],
                    [
                        "IMH-Variable-2"
                    ],
                    [
                        "IMH-Variable-3"
                    ],
                    [
                        "IMH-Variable-4"
                    ],
                    [
                        "IMH-Variable-5"
                    ]
                ]
            }
        ],
        "VariableLayoutItems" : [
            {
                "VariableName" : "IMH-Variable-0",
                "LabelMap" : {
                    "IMH-Answer-0" : "Yes",
                    "IMH-Answer-1" : "No"
                },
                "FormatDirectionHint" : "horizontal"
            },
            {
                "VariableName" : "IMH-Variable-1",
                "LabelMap" : {
                    "IMH-Answer-2" : "Yes",
                    "IMH-Answer-3" : "No"
                },
                "FormatDirectionHint" : "horizontal"
            },
            {
                "VariableName" : "IMH-Variable-2",
                "LabelMap" : {
                    "IMH-Answer-4" : "Yes",
                    "IMH-Answer-5" : "No"
                },
                "FormatDirectionHint" : "horizontal"
            },
            {
                "VariableName" : "IMH-Variable-3",
                "LabelMap" : {
                    "IMH-Answer-6" : "Yes",
                    "IMH-Answer-7" : "No"
                },
                "FormatDirectionHint" : "horizontal"
            },
            {
                "VariableName" : "IMH-Variable-4",
                "LabelMap" : {
                    "IMH-Answer-8" : "Yes",
                    "IMH-Answer-9" : "No"
                },
                "FormatDirectionHint" : "horizontal"
            },
            {
                "VariableName" : "IMH-Variable-5",
                "LabelMap" : {
                    "IMH-Answer-10" : "Yes",
                    "IMH-Answer-11" : "No"
                },
                "FormatDirectionHint" : "horizontal"
            }
        ]
    }
}
Hide JSON