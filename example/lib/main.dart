import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_share/image_share.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> didPressActionButton() async {
    await ImageShare.shareImage(filePath: "assets/image.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: Image.asset("assets/image.jpg"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => didPressActionButton(),
            child: Icon(Icons.share)
        ),
      ),
    );
  }
}
