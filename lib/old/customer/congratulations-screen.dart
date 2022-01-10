import 'package:financial_freedom/old/Model/ProductsArguments.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:financial_freedom/old/widgets/common/routes.dart';
import 'package:financial_freedom/old/widgets/customer/customer-profile.dart';
import 'package:flutter/material.dart';

class CongratulationsScreen extends StatefulWidget {
  final id;
  final email;
  final String loanType;
  CongratulationsScreen({this.id, this.email, this.loanType});
  @override
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => CustomerProfile(
              customerID: widget.id.toString(),
            ),
          ),
        );
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
                            color: Colors.white,
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
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'You have Successfully registered a Customer',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    'Share the Personalised offers with your customer\nCheck out the offers we have curated on the Next page',
                    style: Theme.of(context).textTheme.headline6.merge(
                          TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  ProductsArguments args = new ProductsArguments(
                    widget.id.toString(),
                    null,
                    widget.email.toString(),
                    allowBack: false,
                    loanType: widget.loanType,
                  );
                  Navigator.pushNamed(context, '/newCustomer/productDetails',
                      arguments: args);
                },
                child: Text("Show Me Offers"),
                color: MyColors.yellowColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
              ),
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
                    'assets/repax.png',
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