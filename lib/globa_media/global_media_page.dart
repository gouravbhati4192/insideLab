import 'package:financial_freedom/old/widgets/common/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'news_details_page.dart';

class MediaPageDesign extends StatefulWidget {
  const MediaPageDesign({key}) : super(key: key);

  @override
  _MediaPageDesignState createState() => _MediaPageDesignState();
}

class _MediaPageDesignState extends State<MediaPageDesign> {

  List<String> employment_type = [
    'Recieves monthly salary',
    'Owns a Business ',
    'Professional / Consultant / Private Practitioner\n/ Freelancer'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_filled),
                text: "Global Media",
              ),
              Tab(
                icon: Icon(Icons.account_box_outlined),
                text: "Tution Media",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _myListView(),
            Center(
              child: Icon(Icons.account_circle),
            ),

          ],
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
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => NewsDetailsPage(),
                ),
              );
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
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0)),
                        child: Image.asset('assets/news_feed_image.jpg',
                          height: 150,
                        ),
                      ),
                      Text("Night driving: Need glare procrtion from heighbeam heahlight",style:
                        TextStyle(fontSize: 16.0),),

                      Text("Night driving: Need glare procrtion from heighbeam heahlight Night driving: Need glare procrtion from heighbeam heahlight"
                          " Night driving: Need glare procrtion from heighbeam heahlight Night driving: Need glare procrtion from heighbeam heahlight",style:
                      TextStyle(fontSize: 12.0,color: Colors.black26),)

                    ],
                  )
                ),
              ),
            ));
      },
    );
  }

}
