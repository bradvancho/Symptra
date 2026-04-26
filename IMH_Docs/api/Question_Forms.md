Question Forms
 

Overview
A QuestionForm is a type of question that the IMH data API returns to support rich input types. These input types include textboxes, checkboxes, radio buttons, numbers, etc. If QuestionForm mode is turned on in the Settings resource, then instead of the Question_SingleChoice object being returned, a QuestionForm object is returned in the responses that include a question.

NOTE:
Supporting the QuestionForm feature is very important to provide a good experience for the patient. The older method of Question_SingleChoice will be deprecated in a future release. Your application should turn on the QuestionForm mode and support the richer question types going forward. The QuestionForm feature is being used for all new questionnaires we develop. If your application does not turn on the QuestionForm feature, then these questionnaires will not be accessible to patients using your application.

This page explains how your client application processes a QuestionForm object by rendering it the screen. This is accomplished by converting the QuestionForm JSON abstraction to a user interface form. Frequently, this means converting the QuestionForm structure to HTML elements. After you display a form to the user, your application will also need to collect the user's input for the form and send that information back to the IMH data API.

List of QuestionForm Samples
Follow this link to view a list of QuestionForm samples. These samples are useful for testing your application to verify that the QuestionForms are being rendered correctly. QuestionForm Samples

Example
Below is an example that shows a basic question form. This question asks the user to input quality attributes for their back pain. These attributes include "dull", "aching", "sharp". To accomplish this, the QuestionForm includes the question text and a collection of boolean variables and their respective labels. The user interface will process this information and typically display checkboxes to collect the user input. The values of the checkboxes are then sent to the IMH API to process and calculate the next question to ask. Here is the QuestionForm sample JSON. The details of this structure are explained the remaining sections.

Sample Question Form
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
    "Question": {
        "QuestionForm": {
            "Text": "How would you describe your back or leg (sciatic) pain?",
            "Model": {
                "Variables": [
                    {
                        "Type": "bool",
                        "VariableName": "IMH-Variable-0"
                    },
                    {
                        "Type": "bool",
                        "VariableName": "IMH-Variable-1"
                    },
                    {
                        "Type": "bool",
                        "VariableName": "IMH-Variable-2"
                    }
                ]
            },
            "Form": {
                "FormLayoutItems": [
                    {
                        "Type": "group",
                        "VariableNames": [
                            "IMH-Variable-0",
                            "IMH-Variable-1",
                            "IMH-Variable-2"
                        ]
                    }
                ],
                "VariableLayoutItems": [
                    {
                        "Label": "Dull",
                        "VariableName": "IMH-Variable-0"
                    },
                    {
                        "Label": "Aching",
                        "VariableName": "IMH-Variable-1"
                    },
                    {
                        "Label": "Sharp",
                        "VariableName": "IMH-Variable-2"
                    }
                ]
            }
        }
    }
}
Summary of the Question Form Sections
The example above is the QuestionForm JSON part of a Question response from the IMH API. Below is a brief description of each section in the structure.

Question Text
Every question form has a Text property that is the question text to display to the user.

Variables
The Model.Variables section contains the collection of inputs expected for the question form. The Variables array has an entry for each variable. The variable model includes a variable name and its type. A variable type is something like "string", "integer", "bool", etc. Depending on the type, there can be other properties that further describe the variable. For example, an integer variable may have "Maximum" and "Minimum" properties to describes the bounds of the integer variable.

Form Layout Items
The next section of the question form structure is the Form.FormatLayoutItems. This section is used to provide an abstraction of the layout of the variables. To render the question form to the screen (ex: to html), your application will typically start with this section. Your application should read the "Type" field in Form.FormLayoutItems to start the process. The "Type" field will either be "variable", "group", or "grid". These are described in more detail in the Form Layout Item section below.

Variable Layout Items
The Form.VariableLayoutItems array contains detailed information that may be necessary to display a variable on the screen. For example, many variables will have a "Label" field in this section that contains the label text your application can apply to an input field.

The following sections go into more detail about the fields in the structure.

Question Text
This field contains the text for the question. For example, "How many meals do you eat per day?" or "When did your back pain begin?" Your application should display the text for the user to read in order to understand the information the question is collecting.

Variables
Each question form contains an array of variables that your application will assign values to and send back to the IMH API. The variables section list all the variables the API is expecting in response to the question. Here are the details about the fields a variable can have.

Field	Value	Example	Details
Type	
bool
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "bool"
} ]
A bool variable can be assigned either true or false. For example, your application can return {"IMH-Variable-0":true}

 	
integer
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "integer"
} ]
An integer variable can be assigned a natural number, their negatives, or zero. For example, your application can return {"IMH-Variable-0":14} The value allowed to be returned for an integer variable can be constrained by the settings of other fields.

 	
string
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "string"
} ]
A string variable can be assigned any reasonable text string. For example, your application can return {"IMH-Variable-0":"I fell off my bike."} A string variable can be constrained in length with other fields.

Enum	
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "string",
    "Enum": [ "IMH-Answer-0", "IMH-Answer-1" ]
} ]
If the Enum field is present, it indicates that one of the values from the Enum array must be assigned to the variable when it is returned to the service. For example, your application can return {"IMH-Variable-0":"IMH-Answer-0"} This model is used frequently for radio button inputs like "Yes" and "No".

Maximum	
 
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "integer",
    "Maximum": 15
} ]
This fields indicates that an integer variable can only accept a value up to the value of this field. If a value greater than Maximum is sent to the service, a validation error is returned.

MaxLength	
 
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "string",
    "MaxLength": 20
} ]
This fields indicates that a string variable can only accept a value in length of a certain number of characters. If a string in length greater than MaxLength is sent to the service, a validation error is returned.

Minimum	
 
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "integer",
    "Minimum": 0
} ]
This fields indicates that an integer variable cannot accept a value below the value of this field. If a value less than Minimum is sent to the service, a validation error is returned.

Required	
"Variables": [ {
    "VariableName": "IMH-Variable-0",
    "Type": "string",
    "Required": true
} ]
If the Required field is present and set to 'true', then a value must be returned for the variable.

Form Layout Item
The Form.FormLayoutItems array contains information about how to render the variables to the user. Your application should look at the Type field to determine the rendering approach. The Type field can be one of the following: "variable", "group", or "grid".

"variable" layout
In this case, the form layout item will contain a "VariableName" field. This indicates that a single variable is to be rendered to the layout. Your application should lookup the variable name in the VariableLayoutItems to see if a label exists for the variable. Your application will also need to access the variable from the Models.Variables section to determine the shape of the variable to be rendered (ex: string->textbox, bool->checkbox, etc.)

?
1
2
3
4
5
6
7
8
"Form": {
    "FormLayoutItems": [
        {
            "Type": "variable",
            "VariableName": "IMH-Variable-0"
        }
    ]
    ...
"group" layout
This case is similar to the simple "variable" case above. Instead of a "VariableName" field, there will be a "VariableNames" array that contains a list of variables to render inside of the group. There may also be a "GroupDisplayName" that contains a string to use for the group label. If your application is rendering to HTML, then a fieldset/legend element is a good match for the "group" type.

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
"Form": {
    "FormLayoutItems": [
        {
            "Type": "group",
            "VariableNames": [
                "IMH-Variable-0",
                "IMH-Variable-1",
                "IMH-Variable-2",
                "IMH-Variable-3"
            ]
        }
    ]
    ...
"grid" layout
This case is used if there are variables that render best into a grid layout. A grid layout has the following fields.

"GridColHeaders" - contains an array of strings that should be used as column headers when the grid is rendered to the layout.

"GridRowHeaders" - contains an array of strings that should be used as row headers when the grid is rendered.

"GridBody" - contains a two-dimensional array with the variable names that should be rendered in each cell of the grid.

This example shows a grid with 3 variables per row for 7 rows.

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
"Form": {
    "FormLayoutItems": [
        {
            "Type": "grid",
            "GridBody": [
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
                    "IMH-Variable-16",
                    "IMH-Variable-17"
                ],
                [
                    "IMH-Variable-18",
                    "IMH-Variable-19",
                    "IMH-Variable-20"
                ]
            ]
        }
    ],
...
Variable Layout Item
A variable layout item contains information to display for the variable. The following fields are included in this structure.

Field	Example	Details
Label	
"VariableLayoutItems": [
     {
          "VariableName": "IMH-Variable-0",
          "Label": "Dull"
     }
The Label field provides a label for a form element. Typically, a bool (checkbox), a string (text input), and an integer input field will provide a label.

LabelMap	
"VariableLayoutItems": [
    {
        "VariableName": "IMH-Variable-0",
        "LabelMap": {
            "IMH-Answer-0": "Less than 1 hour",
            "IMH-Answer-1": "1 to 2 hours",
            "IMH-Answer-2": "2 to 4 hours",
            "IMH-Answer-3": "4 to 8 hours",
            "IMH-Answer-4": "8 to 12 hours",
            "IMH-Answer-5": "12 to 18 hours",
            "IMH-Answer-6": "18 to 24 hours",
            "IMH-Answer-7": "More than 24 hours"
        },
    }
]
The LabelMap field provides a lookup collection for a string/enum variable type. Each enum in the variable has a corresponding entry in the map to provide the label to be displayed to the user for the enum

Placeholder	
"VariableLayoutItems": [
    {
        "VariableName": "IMH-Variable-0",
        "Label": "When",
        "Placeholder": "ex: 1997"
        },
    }
]
The Placeholder field is a string that can be placed into an input field to prompt the user on the type of input expected. This string can be placed into an input placeholder=""... element in HTML.

Validation
When your application sends the user inputs to the IMH API, the service validates all inputs against the fields in the variable model. If errors are found, the QuestionForm is returned along with validation messages. Your application should then display the QuestionForm again and include the validation messages so the user can correct the inputs.

Here is an example of a QuestionForm with validation messages.

{
    "Question": {
        "QuestionForm": {
            "Text": "On a scale of 0 (no pain) to 10 (highest), what is your level of back pain?",
            "Model": {
                ...
            },
            "Form": {
                ...
            },
            "ValidationMessages": {
                "IMH-Variable-0": "The input for 'Current pain' is not a valid number.",
                "IMH-Variable-1": "The input for 'Average pain' is not a valid number.",
                "IMH-Variable-2": "The input for 'Lowest pain' is not a valid number.",
                "IMH-Variable-3": "The input for 'Highest pain' is not a valid number."
            }
        }
    }
}        
© 2014-2023 Primetime Medical Software, Inc.