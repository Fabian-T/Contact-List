import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late List<String> _demoData;
  late ScrollController _controller;
  String time1 = timeago.format(new DateTime.now().subtract(new Duration(minutes: 15))).toString();
  String time2 = timeago.format(new DateTime.now().subtract(new Duration(minutes: 30))).toString();
  String time3 = timeago.format(new DateTime.now().subtract(new Duration(minutes: 45))).toString();
  String time4 = timeago.format(new DateTime.now().subtract(new Duration(hours: 1))).toString();
  String time5 = timeago.format(new DateTime.now().subtract(new Duration(hours: 1,minutes: 15))).toString();
  String time6 = timeago.format(new DateTime.now().subtract(new Duration(hours: 1,minutes: 30))).toString();
  String time7 = timeago.format(new DateTime.now().subtract(new Duration(hours: 1, minutes: 45))).toString();
  String time8 = timeago.format(new DateTime.now().subtract(new Duration(minutes: 5))).toString();
  String time9 = timeago.format(new DateTime.now().subtract(new Duration(minutes: 10))).toString();

  @override
  void initState() {
    final time = new DateTime.now().subtract(new Duration(minutes: 15)).toString();
    // initializing states
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _demoData = [
      "user: Chan Saw Lin\n" +
          "phone: 0152131113\n" +
          "check-in: " + time1,
      "user: Lee Saw Loy\n" +
          "phone: 0161231346\n" +
          "check-in: " + time2,
      "user: Khaw Tong Lin\n" +
          "phone: 0158398109\n" +
          "check-in: " + time3,
      "user: Lim Kok Lin\n" +
          "phone: 0168279101\n" +
          "check-in: " + time4,
    ];
    _scaffoldKey = GlobalKey();
    super.initState();
  }
  _scrollListener(){
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('End of list'),
        ),
      );
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }
  // List view area
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Contact List'),
          ),
          body: RefreshIndicator(
            child: ListView.builder(
              controller: _controller,
              itemBuilder: (context, idx) {
                // List Item
                return Card(
                  child: ListTile(
                    title: Text(_demoData[idx]),
                  ),
                );
              },
              itemCount: _demoData.length,
              physics: const AlwaysScrollableScrollPhysics(),
            ),
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                    () {
                  setState(() {
                    _demoData.addAll(["user: Low Jun Wei\n" +
                        "phone: 0112731912\n" +
                        "check-in: " + time5,
                      "user: Yong Weng Kai\n" +
                          "phone: 0172332743\n" +
                          "check-in: " + time6,
                      "user: Jayden Lee\n" +
                          "phone: 0191236439\n" +
                          "check-in: " + time7,
                      "user: Kong Kah Yan\n" +
                          "phone: 0111931233\n" +
                          "check-in: " + time8,
                      "user: Jasmine Lau\n" +
                          "phone: 0162879190\n" +
                          "check-in: " + time9,]);
                  });
                  _scaffoldKey.currentState?.showSnackBar(
                    SnackBar(
                      content: const Text('Page Refreshed'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
