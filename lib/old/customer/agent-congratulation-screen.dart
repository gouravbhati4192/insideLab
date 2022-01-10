import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:financial_freedom/old/widgets/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgentCongratulationsScreen extends StatefulWidget {
  // final id;
  // final email;
  // AgentCongratulationsScreen({this.id, this.email});
  @override
  _AgentCongratulationsScreenState createState() => _AgentCongratulationsScreenState();
}

class _AgentCongratulationsScreenState extends State<AgentCongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, Routes.home, (route) => false);
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, _, __) => CustomerProfile(
        //       customerID: widget.id.toString(),
        //     ),
        //   ),
        // );
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'Congratulations !',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                            fontSize: 35.0,
                            color: MyColors.yellowColor(),
                          ),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Center(
                  child: Text(
                    'You have Successfully completed the Registration journey',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Text(
                      'We are reviewing your profile.\nOur Service team will contact shortly.\nThanks for the patience.',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Row(
                  children: [
                    Text(
                      'Return to',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => FinancialFreedomLogin()), (route) => false);
                      },
                      child: Text(
                        '  Login',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(
                                fontSize: 18,
                                color: Colors.yellow,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // FlatButton(
              //   onPressed: () {
              //     // ProductsArguments args = new ProductsArguments(
              //     //     widget.id.toString(), null, widget.email.toString(),
              //     //     allowBack: false);
              //     // Navigator.pushNamed(context, '/newCustomer/productDetails',
              //     //     arguments: args);
              //   },
              //   child: Text("Show Me Offers"),
              //   color: MyColors.yellowColor(),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(
              //       10.0,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 20.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/agentcongrats.png',
                    scale: 2.5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Navigator.popAndPushNamed(
//                                                 context, Routes.home,
//                                                 arguments: args)
//                                             .then((_) =>
//                                                 _formkey.currentState.reset());