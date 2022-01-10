import 'dart:convert';

import 'package:financial_freedom/old/Model/Agent.dart';
import 'package:financial_freedom/old/widgets/common/ApiConstants.dart';
import 'package:financial_freedom/old/widgets/common/BottomNavigationWidgets.dart';
import 'package:financial_freedom/old/widgets/common/CallApi.dart';
import 'package:financial_freedom/old/widgets/common/DualRadioButtonCard.dart';
import 'package:financial_freedom/old/widgets/common/ShowSnackBar.dart';
import 'package:financial_freedom/old/widgets/registration/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

int selectedValue, selectedValue1, selectedValue2, selectedValue3;
CallApi _callapi = new CallApi();
final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

bool _checkValue = false;
final List<TextEditingController> _controllers = new List.generate(7, (int n) {
  return new TextEditingController();
});

class ConflictOfInterest extends StatefulWidget {
  final String title;
  final Agent agent;

  ConflictOfInterest({Key key, this.title, this.agent}) : super(key: key);
  @override
  _ConflictOfInterestState createState() => _ConflictOfInterestState();
}

class _ConflictOfInterestState extends State<ConflictOfInterest> {
  String queJson;
  var questiondecodeJson;
  Future questions;

  @override
  initState() {
    super.initState();
    selectedValue = 1;
    selectedValue1 = 1;
    selectedValue2 = 1;
    selectedValue3 = 1;
    print("###User id : ${widget.agent.uid}");
    questions = _callapi.callGetApi(ApiConstants.GET_QUESTION_LIST, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        child: FutureBuilder(
          future: questions,
          /*callQuestionListApi()*/
          builder: (context, snapshot) {
            Widget child;
            if (snapshot.hasData) {
              questiondecodeJson = json.decode(snapshot.data);
              print('Snapshot Data : ${questiondecodeJson['data']}');
              agentDetails.questionListJson =
                  questiondecodeJson['data']['questions'];
              child = Form(
                key: _formKey,
                child: ListView.builder(
                  itemCount: agentDetails.questionListJson.length,
                  itemBuilder: (context, index) {
                    var key = (index + 1);
                    var questionType = questiondecodeJson['data']['questions']
                        [key.toString()]['answer_type'];
                    if (questionType == 'descriptive') {
                      var questionText = questiondecodeJson['data']['questions']
                          [key.toString()]['question'];
                      return textQuestion(questionText, key);
                    } else if (questionType == 'radio') {
                      var questionText = questiondecodeJson['data']['questions']
                          [key.toString()]['question'];
                      return radioQuestion(questionText, key);
                    } else {
                      var questionText = questiondecodeJson['data']['questions']
                          [key.toString()]['question'];

                      var options = questiondecodeJson['data']['questions']
                          [key.toString()]['options'];
                      return dropdownQuestion(questionText, options, key);
                    }
                  },
                  // children: [

                  //   Row(
                  //     children: [
                  //       Expanded(
                  //         child: questionText(questiondecodeJson['data']
                  //                 ['questions']['7']['question']

                  //             /*"Are you or any direct member of your family works in Politics or Government?"*/),
                  //       ),
                  //       DualRadioButtonCard(
                  //         option1: "Yes",
                  //         option2: "No",
                  //         selectedValue: selectedValue3,
                  //         onChanged: (int selectionValue) {
                  //           setState(() {
                  //             selectedValue3 = selectionValue;
                  //             (selectionValue == 0)
                  //                 ? widget..ans7 = 'yes'
                  //                 : widget.agent.ans7 = 'no';
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  //   SizedBox(
                  //     height: 15,
                  //   ),
                  //   Row(
                  //     children: [
                  //       Checkbox(
                  //         value: _checkValue,
                  //         onChanged: (bool value) {
                  //           if (_checkValue == false) {
                  //             setState(() {
                  //               _checkValue = true;
                  //             });
                  //           } else if (_checkValue == true) {
                  //             setState(() {
                  //               _checkValue = false;
                  //             });
                  //           }
                  //         },
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           'I do hereby certify that the information given above is complete and correct.',
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                ),
              );
            } else if (snapshot.hasError) {
              child = Container(
                padding: new EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        child: Container(
                          padding: new EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red[900],
                              ),
                              Text('Something went wrong')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              child = Center(
                child: CircularProgressIndicator(),
              );
            }
            return child;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationWidgets(
        onPressedNext: (BuildContext btncontext) {
          onNextClick(btncontext);
        },
        onPressedCancel: (BuildContext buildContext) {
          Navigator.pop(buildContext);
        },
        nextButtonName: 'Next',
        cancelButtonName: 'Cancel',
      ),
    );
  }

  Widget textQuestion(dynamic questionData, int key) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: questionText(questionData),
        ),
        TextFormField(
          autocorrect: true,
          maxLines: null,
          controller: _controllers[key],
          keyboardType: TextInputType.multiline,
          style: (TextStyle(color: Colors.grey[800])),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          validator: (value) => validateTextfields(_controllers[key].text),
          onSaved: (value) {
            setValue(key, value);
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget radioQuestion(dynamic questionText, int key) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: questionText,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // WidgetSpan(
                    //   child: Tooltip(
                    //     preferBelow: true,
                    //     message: questiondecodeJson['data']['questions']
                    //         [key.toString()]['explanation'],
                    //     child: Icon(
                    //       Icons.info,
                    //       color: Colors.grey[700],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            DualRadioButtonCard(
              option1: 'Yes',
              option2: 'No',
              selectedValue: selectedValue,
              onChanged: (int selectionValue) {
                setState(() {
                  selectedValue = selectionValue;
                  (selectionValue == 0)
                      ? setValue(key, 'yes')
                      : setValue(key, 'no');
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget dropdownQuestion(dynamic questionData, dynamic options, int key) {
    List<String> optionsList = new List<String>();
    for (var i = 0; i < options.length; i++) {
      optionsList.add(options[i]['key']);
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: questionText(questionData),
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          validator: (value) => validateTextfields(value),
          items: optionsList
              .map((label) => DropdownMenuItem(
                    child: Text(
                      label,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    value: label,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              setValue(key, value);
            });
          },
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  void setValue(int key, String value) {
    switch (key) {
      case 1:
        widget.agent.ans1 = value;
        break;
      case 2:
        widget.agent.ans2 = value;
        break;
      case 3:
        widget.agent.ans3 = value;
        break;
      case 4:
        widget.agent.ans4 = value;
        break;
      case 5:
        widget.agent.ans5 = value;
        break;
      case 6:
        widget.agent.ans6 = value;
        break;
      case 7:
        widget.agent.ans7 = value;
        break;
    }
  }

  String validateTextfields(String value) {
    if (value.isEmpty) {
      return "*All fields are mandatary";
    }
    return null;
  }

  Widget questionText(dynamic questionText) {
    return Text(
      questionText,
      style: TextStyle(
          color: Colors.indigo, fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  Widget view(var questiondecodeJson, Agent agent) {
    var queList =
        questiondecodeJson['data']['questions']['6']['related_questions'];
    if (selectedValue2 == 0) {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionText(queList[0]['yes']['1']['question']
              /*"What were your role and position?"*/),
          TextFormField(
            autocorrect: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: (TextStyle(color: Colors.grey[800])),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            validator: (value) => validateTextfields(value),
            onSaved: (value) {
              agent.ans61 = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          questionText(queList[0]['yes']['2']['question']

              /*"How many years have you worked in the industry?"*/),
          TextFormField(
            autocorrect: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: (TextStyle(color: Colors.grey[800])),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            validator: (value) => validateTextfields(value),
            onSaved: (value) {
              agent.ans62 = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          questionText(queList[0]['yes']['3']['question']

              /*"How many years since you are not working in the industry?"*/),
          TextFormField(
            autocorrect: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: (TextStyle(color: Colors.grey[800])),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            validator: (value) => validateTextfields(value),
            onSaved: (value) {
              agent.ans63 = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          questionText(queList[0]['yes']['4']['question']

              /*   "Have you worked as an agent, broker in financial sector?"*/),
          TextFormField(
            autocorrect: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: (TextStyle(color: Colors.grey[800])),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            validator: (value) => validateTextfields(value),
            onSaved: (value) {
              agent.ans64 = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
    }

    return new Container();
  }

  void onNextClick(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      scaffoldKey.currentState.showSnackBar(
        ShowSnackBar('Please fill all the fields').showError(),
      );
    }
    // } else if (!_checkValue) {
    //   scaffoldKey.currentState.showSnackBar(
    //     ShowSnackBar('Please certify the details by clicking given checkbox')
    //         .showError(),
    //   );
    // }
    else {
      _formKey.currentState.save();
      if (widget.agent.ans5 == null) {
        widget.agent.ans5 = 'no';
      }
      if (widget.agent.ans6 == null) {
        widget.agent.ans6 = 'no';
      }
      Navigator.pushNamed(context, '/bankDetails');
    }
  }
}
