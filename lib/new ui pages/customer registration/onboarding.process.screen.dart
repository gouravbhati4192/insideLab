import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:steps/steps.dart';

class OnboardingProcessScreen extends StatefulWidget {
  OnboardingProcessScreen({Key key}) : super(key: key);

  @override
  _OnboardingProcessScreenState createState() =>
      _OnboardingProcessScreenState();
}

class _OnboardingProcessScreenState extends State<OnboardingProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {},
                      fillColor: MyColors.yellowColor(),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Lets Start',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .copyWith(
                                fontSize: 14,
                                color: MyColors.backgroundColor(),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 8.0, 0.0, 0.0),
              child: Text(
                'Steps on Onboarding Customer',
                style: Theme.of(context).textTheme.headline5.merge(
                      TextStyle(
                        fontSize: 20,
                        color: MyColors.backgroundColor(),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              ),
            ),
            buildStepper()
          ],
        ),
      ),
    );
  }

  buildStepper() {
    infoBoxes(main, sub) {
      return {
        'color': Colors.white,
        'background': Colors.green,
        'label': '',
        'content': Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  main,
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 14,
                          color: MyColors.backgroundColor(),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  sub,
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 14,
                          color: MyColors.backgroundColor(),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      };
    }

    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: Steps(
          direction: Axis.vertical,
          size: 14.0,
          path: {'color': Colors.green, 'width': 2.0},
          steps: [
            {
              'color': Colors.white,
              'background': Colors.green,
              'label': '',
              'content': Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 8.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Fill Cutomer Details Form',
                        style: Theme.of(context).textTheme.headline5.merge(
                              TextStyle(
                                fontSize: 14,
                                color: MyColors.backgroundColor(),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Enter required details of the customer',
                        style: Theme.of(context).textTheme.headline5.merge(
                              TextStyle(
                                fontSize: 14,
                                color: MyColors.backgroundColor(),
                              ),
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'validate customer consent to share their details with an OTP',
                        style: Theme.of(context).textTheme.headline5.merge(
                              TextStyle(
                                fontSize: 14,
                                color: MyColors.backgroundColor(),
                              ),
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Upload KYC',
                        style: Theme.of(context).textTheme.headline5.merge(
                              TextStyle(
                                fontSize: 14,
                                color: MyColors.backgroundColor(),
                              ),
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          RawMaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {},
                            fillColor: MyColors.textBoxColor(),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                'Aadhaar Card',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    .copyWith(
                                      fontSize: 14,
                                      color: MyColors.yellowColor(),
                                    ),
                              ),
                            ),
                          ),
                          Spacer(),
                          RawMaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {},
                            fillColor: MyColors.textBoxColor(),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                'PAN Card',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    .copyWith(
                                      fontSize: 14,
                                      color: MyColors.yellowColor(),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            },
            infoBoxes('Share Loan Products',
                'Generate the eligible loan offers and Share with the customer to Compare & Select.'),
            infoBoxes('Select Loan Products',
                'With your customer\'s direction, select the loan they want. And, validate the selection with OTP'),
            infoBoxes('Upload Documents',
                'Gather required documents of the customer, and upload them on the app. If correction or additional document shall be requried we would notify you.'),
            infoBoxes('Submit File',
                'Submit customer Loan Application, and simply track the Loan Process.'),
          ],
        ),
      ),
    );
  }
}
