import 'package:financial_freedom/controller/user.controller.dart';
import 'package:financial_freedom/old/widgets/common/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCardScreen extends StatefulWidget {
  MyCardScreen({Key key}) : super(key: key);

  @override
  _MyCardScreenState createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  UserController userController;
  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyColors.backgroundColor(),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.zoom_out_map_sharp,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Business Card',
          style: TextStyle(
            fontSize: 16,
            color: MyColors.backgroundColor(),
          ),
        ),
        actions: [
          SizedBox(
            width: 60,
            child: IconButton(
              onPressed: () {
                var message =
                    'Hey! Check Out My Business Card\n${Uri.encodeComponent("https://insiderlab.wostore.in/#/agent-card/")}' +
                        userController.user.id.toString();
                var url = "whatsapp://send?text=" + message;

                launch(url);
              },
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),

            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            children: [
              insiderLabCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                child: Text(
                  userController.user.name ?? "",
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 24,
                          color: MyColors.backgroundColor(),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                child: Text(
                  'Financial Therapist',
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 15,
                          color: MyColors.textBoxColor(),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: Text(
                  userController.user.mobile ?? "",
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 15,
                          color: MyColors.backgroundColor(),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  userController.user.email ?? "",
                  style: Theme.of(context).textTheme.headline5.merge(
                        TextStyle(
                          fontSize: 16,
                          color: MyColors.backgroundColor(),
                          fontWeight: FontWeight.w700,
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

  insiderLabCard() {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Hero(
          tag: 'insiderCard',
          child: Card(
            color: MyColors.backgroundColor(),
            shadowColor: Colors.black,
            elevation: 10.0,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 0.0,
                            left: 20.0,
                            top: 10.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "powered by,",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 0.0,
                            right: 10.0,
                            top: 10.0,
                          ),
                          child: Icon(
                            Icons.zoom_out_map_rounded,
                            color: MyColors.backgroundColor(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(
                          'assets/yellow-full.png',
                          height: 60.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 0.0,
                        left: 10.0,
                        right: 10.0,
                        top: 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "www.insiderlab.in",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.home_filled,
                                color: MyColors.yellowColor(),
                              ),
                              SizedBox(
                                width: 30,
                                // height: 30,
                                child: Divider(
                                  thickness: 1,
                                  color: MyColors.yellowColor(),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "admin@insiderlab.in",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
