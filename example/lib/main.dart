import 'package:flutter/material.dart';
import 'package:unique_identifier_3/unique_identifier_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var serial = "";
  @override
  void initState() {
    super.initState();
    getSerial();
  }

  void getSerial() async {
    serial = await UniqueIdentifier.serial ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $serial\n'),
        ),
      ),
    );
  }
}
