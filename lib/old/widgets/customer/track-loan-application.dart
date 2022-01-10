import 'package:flutter/material.dart';

import 'customer-profile.dart';

class TrackLoanApplication extends StatefulWidget {
  @override
  _TrackLoanApplicationState createState() => _TrackLoanApplicationState();
}

class _TrackLoanApplicationState extends State<TrackLoanApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: backgroundColor(),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Track Loan Application',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  processSegment(
                    'In-Process',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    true,
                  ),
                  processSegment(
                    'Document Collection',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    false,
                  ),
                  processSegment(
                    'Document Collection',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    false,
                  ),
                  processSegment(
                    'Document Collection',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    false,
                  ),
                  processSegment(
                    'Document Collection',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    false,
                  ),
                  processSegment(
                    'Document Collection',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    false,
                  ),
                  processSegment(
                    'Document Collection',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    false,
                    false,
                  ),
                  processSegment(
                    'In-Process',
                    "This is description",
                    "5:00pm; 24th April 2021",
                    true,
                    false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget processSegment(
      String title, String detail, String time, bool end, bool start) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(top: start ? 10.0 : 0.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue,
                      child: Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    end
                        ? SizedBox.shrink()
                        : SizedBox(
                            height: 100,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: start ? 20.0 : 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                        ),
                        Text(
                          time,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 15.0, bottom: 0.0),
                    child: SizedBox(
                      height: 60,
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: detail,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
