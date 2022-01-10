import 'package:financial_freedom/old/Model/customerData.dart';
import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class FindLoanQuestionAnswer extends StatefulWidget {
  const FindLoanQuestionAnswer({key}) : super(key: key);

  @override
  _FindLoanQuestionAnswerState createState() => _FindLoanQuestionAnswerState();
}

class _FindLoanQuestionAnswerState extends State<FindLoanQuestionAnswer> {
  List<int> rec_month_se__from_com = [0, 0];
  List<int> rec_month_se__from_busines = [0, 1];
  List<int> rec_month_se__from_com_as_doc = [0, 2, 0];
  List<int> rec_month_se__from_com_as_ca = [0, 2, 1];
  List<int> rec_month_se__from_com_as_cs = [0, 2, 2];
  List<int> rec_month_se__from_com_as_ea = [0, 2, 3];
  List<int> rec_month_se__from_com_as_free = [0, 2, 4];
  List<int> rec_month_se__from_com_as_other = [0, 2, 5];

  List<int> own_busines_for_bus_mort = [1, 0, 0];
  List<int> own_busines_for_bus_not_mort = [1, 0, 1];
  List<int> own_busines_cust_fot_them = [1, 1];
  List<int> own_businesas_doc = [1, 2, 0];
  List<int> own_businesas_ca = [1, 2, 1];
  List<int> own_businesas_cs = [1, 2, 2];
  List<int> own_businesas_ea = [1, 2, 3];
  List<int> own_businesas_free = [1, 2, 4];
  List<int> own_businesas_other = [1, 2, 5];

  List<int> as_doc = [2, 0];
  List<int> as_ca = [2, 1];
  List<int> as_cs = [2, 2];
  List<int> as_ea = [2, 3];
  List<int> as_free = [2, 4];
  List<int> as_other = [2, 5];

  List list_click_index = new List();

  String _var4 = "Analyse the type of loan my customer should get";
  String _var5 = "Analyse the type of loan my customer should get";
  String _var3 = "Find out the loan for my customer";
  String _var2 = "Find out the loan for my customer";
  String _var1 = "What is the employment type of \n your customer ?";

  int _step_counter = 0;

  List<String> employment_type = [
    'Recieves monthly salary',
    'Owns a Business ',
    'Professional / Consultant / Private Practitioner\n/ Freelancer'
  ];

  List<String> salary_type = [
    'From a company',
    'From own business',
    'From a company as(CA/CS/Doctor) '
  ];

  List<String> from_company_type_ca_doc = [
    'Doctor',
    'Chartered Accountant',
    'Company Security',
    'Engineer/Architect',
    'Freelancer,Professional Consultant',
    'Other'
  ];

  List<String> own_busines_type = [
    'Customer need the loan for business',
    'Customer need the loan for themselves (not the business) ',
    'Customer is a CA/CS or any kind of Doctor'
  ];

  List<String> cust_need_for_buiness_type = [
    'Customer will mortage a property or any kind of company asset for the Loan ? ',
    'Customer will not mortage. will take on the basis of turnover and profits ?'
  ];

  List<String> customer_is_type = [
    'Doctor',
    'Chartered Accountant',
    'Company Security',
    'Engineer/Architect',
    'Freelancer,Professional Consultant',
    'Other'
  ];

  bool _isVisible4 = false;
  bool _isVisible5 = false;
  bool _isVisible3 = false;
  bool _isVisible2 = true;
  bool _isVisible1 = true;

  bool _isVisible_final = false;
  bool _isVisible_step_all = true;

  int _loan_type = 0;

  String _butt_text = "Personal Loan";

  var _final_step_point_vis = false;

  var _final_step_line_vis = true;

  Customer
  customerData = new Customer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Select Loan Type",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ],
        ),
        /*actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 10.0,
            ),
            child: const Icon(
              Icons.cancel,
              size: 25,
              color: GetColor.darkgray_background,
            ),
          ),
        ],*/
      ),
      body: Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
          child: Column(
            children: [
              //////////////////////////////////////////////////////////////////////
              Visibility(
                visible: _isVisible5,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: GetColor.sandybrown,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: GetColor.darkgray_background,
                              ),
                            ),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            _var5,
                            style: TextStyle(
                              color: GetColor.darkslategray,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          width: 2.0,
                          decoration: const BoxDecoration(
                              color: GetColor.lightgray,
                              shape: BoxShape.rectangle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //////////////////////////////////////////////////////////////////////

              Visibility(
                visible: _isVisible4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: GetColor.sandybrown,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: GetColor.darkgray_background,
                              ),
                            ),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            _var4,
                            style: TextStyle(
                              color: GetColor.darkslategray,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          width: 2.0,
                          decoration: const BoxDecoration(
                              color: GetColor.lightgray,
                              shape: BoxShape.rectangle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

//////////////////////////////////////////////////////////////////////

              Visibility(
                visible: _isVisible3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: GetColor.sandybrown,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: GetColor.darkgray_background,
                              ),
                            ),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            _var3,
                            style: TextStyle(
                              color: GetColor.darkslategray,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          width: 2.0,
                          decoration: const BoxDecoration(
                              color: GetColor.lightgray,
                              shape: BoxShape.rectangle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

//////////////////////////////////////////////////////////////////////

              Visibility(
                visible: _isVisible2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: GetColor.sandybrown,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.check_rounded,
                                size: 18,
                                color: GetColor.darkgray_background,
                              ),
                            ),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            _var2,
                            style: TextStyle(
                              color: GetColor.darkslategray,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          width: 2.0,
                          decoration: const BoxDecoration(
                              color: GetColor.lightgray,
                              shape: BoxShape.rectangle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

//////////////////////////////////////////////////////////////////////

              Visibility(
                visible: _isVisible1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _final_step_point_vis,
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: const BoxDecoration(
                                      color: GetColor.sandybrown,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: GetColor.darkgray_background,
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ]),
                        Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: Text(
                            _var1,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: _final_step_line_vis,
                      child: Container(
                        margin: EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 50,
                            width: 2.0,
                            decoration: const BoxDecoration(
                                color: GetColor.lightgray,
                                shape: BoxShape.rectangle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: _isVisible_step_all,
                child: Expanded(
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 12.0,
                      child: Expanded(child: _myListView()),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: _isVisible_final,
                child: Expanded(
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 12.0,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 15.0, left: 15.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "We recommend you should offer:",
                                style: TextStyle(
                                  color: GetColor.darkslategray,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20.0, left: 15.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _butt_text.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 25.0, left: 15.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                style: TextStyle(
                                  color: GetColor.darkslategray,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 25.0, left: 15.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                style: TextStyle(
                                  color: GetColor.darkslategray,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Routes.newcustomer);
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  GetColor.darkslategray),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  GetColor.darkslategray),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                  side: BorderSide(
                                                      color: GetColor
                                                          .darkslategray))),
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.all(12.0),
                                            child: const Text(
                                              'Select Another Loan Type',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                        onPressed: () {

                                          Navigator.pushNamed(context, Routes.profesionalLoan,
                                              arguments: customerData);

                                          /*switch (_loan_type) {
                                            case 1:
                                              setState(() {
                                                customerData.loanType = 'Personal';
                                              });
                                              Navigator.pushNamed(context, Routes.profesionalLoan,
                                                  arguments: customerData);
                                              break;
                                            case 2:
                                              setState(() {
                                                customerData.loanType = 'Professional';
                                              });
                                              Navigator.pushNamed(context, Routes.profesionalLoan,
                                                  arguments: customerData);
                                              break;
                                            case 3:
                                              setState(() {
                                                customerData.loanType = 'Business';
                                              });
                                              Navigator.pushNamed(context, Routes.profesionalLoan,
                                                  arguments: customerData);
                                              break;
                                          }*/

                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  GetColor.darkgray_background),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  GetColor.darkgray_background),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                  side: BorderSide(
                                                      color: GetColor
                                                          .darkgray_background))),
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.all(12.0),
                                            child: Text(
                                              "Continue with " + _butt_text,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myListView() {
    return ListView.builder(
      itemCount: employment_type.length,
      itemBuilder: (context, index) {
        final item = employment_type[index];
        return GestureDetector(
            onTap: () {
              onClickAction(index);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
              child: Card(
                color: GetColor.sandybrown,
                margin: const EdgeInsets.all(5.0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: TextStyle(color: GetColor.darkslategray),
                      )),
                ),
              ),
            ));
      },
    );
  }

  void onClickAction(int pos) {
    list_click_index.add(pos);

    _step_counter++;

    if (_step_counter == 1) {
      setState(() {
        _isVisible2 = true;
        _isVisible3 = true;

        _var1 = employment_type[pos];
        _var2 = "What is the employment type of your customer ?";
        _var3 = "Analyse the type of loan my customer should get";

        switch (pos) {
          case 0:
            setState(() {
              employment_type = [
                'From a company',
                'From own business',
                'From a company as(CA/CS/Doctor) '
              ];
            });
            break;

          case 1:
            setState(() {
              employment_type = [
                'Customer need the loan for business',
                'Customer need the loan for themselves (not the business) ',
                'Customer is a CA/CS or any kind of Doctor'
              ];
            });
            break;

          case 2:
            setState(() {
              employment_type = [
                'Doctor',
                'Chartered Accountant',
                'Company Security',
                'Engineer/Architect',
                'Freelancer,Professional Consultant',
                'Other'
              ];
            });
            break;
        }
      });
    }

    if (_step_counter == 2) {
      if (checkArray()) {
        setState(() {
          _isVisible_step_all = false;
          _isVisible_final = true;
          _final_step_line_vis = false;
          _final_step_point_vis = true;

          switch (_loan_type) {
            case 1:
              _butt_text = "Personal Loan";
              setState(() {
                customerData.loanType = 'Personal';
              });
              break;
            case 2:
              _butt_text = "Professional Loan";
              setState(() {
                customerData.loanType = 'Professional';
              });
              break;
            case 3:
              _butt_text = "Business Loan";
              setState(() {
                customerData.loanType = 'Business';
              });
              break;
          }
        });
      }
      setState(() {
        _isVisible2 = true;
        _isVisible3 = true;
        _isVisible4 = true;

        _var2 = _var1;
        _var1 = employment_type[pos];
        _var3 = "What is the employment type of \n your customer ?";
        _var4 = "Analyse the type of loan my customer should get";

        switch (pos) {
          case 0:
            setState(() {
              employment_type = [
                'Customer will mortage a property or \n any kind of company asset for the Loan ? ',
                'Customer will not mortage. will take \n on the basis of turnover and profits ?'
              ];
            });
            break;

          case 1:
            setState(() {});
            break;

          case 2:
            setState(() {
              employment_type = [
                'Doctor',
                'Chartered Accountant',
                'Company Security',
                'Engineer/Architect',
                'Freelancer,Professional Consultant',
                'Other'
              ];
            });
            break;
        }
      });
    }

    if (_step_counter == 3) {

      if(checkArray()) {
        setState(() {
          _isVisible_step_all = false;
          _isVisible_final = true;
          _final_step_line_vis = false;
          _final_step_point_vis = true;

          switch (_loan_type) {
            case 1:
              _butt_text = "Personal Loan";
              break;
            case 2:
              _butt_text = "Professional Loan";
              break;
            case 3:
              _butt_text = "Business Loan";
              break;
          }
        });
      }

      setState(() {
        _isVisible2 = true;
        _isVisible3 = true;
        _isVisible4 = true;
        _isVisible5 = true;

        _var3 = _var2;
        _var2 = _var1;
        _var1 = employment_type[pos];
        _var4 = "What is the employment type of your customer ?";
        _var5 = "Analyse the type of loan my customer should get";

        _isVisible_step_all = false;
        _isVisible_final = true;
      });
    }
  }

  bool checkArray() {
    Function eq = const ListEquality().equals;

    if (eq(list_click_index, rec_month_se__from_com)) {
      _loan_type = 1;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_busines)) {
      _loan_type = 1;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_com_as_doc)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_com_as_ca)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_com_as_cs)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_com_as_ea)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_com_as_free)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, rec_month_se__from_com_as_other)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, own_busines_for_bus_mort)) {
      _loan_type = 3;
      return true;
    } else if (eq(list_click_index, own_busines_for_bus_not_mort)) {
      _loan_type = 3;
      return true;
    } else if (eq(list_click_index, own_busines_cust_fot_them)) {
      _loan_type = 1;
      return true;
    } else if (eq(list_click_index, own_businesas_doc)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, own_businesas_ca)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, own_businesas_cs)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, own_businesas_ea)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, own_businesas_free)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, own_businesas_other)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, as_doc)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, as_ca)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, as_cs)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, as_ea)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, as_free)) {
      _loan_type = 2;
      return true;
    } else if (eq(list_click_index, as_other)) {
      _loan_type = 2;
      return true;
    } else {
      return false;
    }
  }
}
