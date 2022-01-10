import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.network(
                            "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                ),
                SliverPadding(
                  padding: new EdgeInsets.all(16.0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                      TabBar(
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          new Tab(icon: new Icon(Icons.info), text: "Tab 1"),
                          new Tab(
                              icon: new Icon(Icons.lightbulb_outline),
                              text: "Tab 2"),
                        ],
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: Center(
              child: Text("Sample text"),
            ),
          ),
        ));
  }
}