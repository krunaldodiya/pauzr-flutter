import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: SizedBox(
        width: 45.0,
        height: 45.0,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            //
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Text("Groups"),
      ),
    );
  }
}
