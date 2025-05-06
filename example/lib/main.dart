import 'dart:async';

import 'package:devdf_android/devdf_android.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _packageInfo = 'Unknown';
  String _regionalInfo = 'Unknown';
  String _localeInfo = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initRegionalInfo();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String packageInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      packageInfo = (await PackageInfo.get()).toString();
    } on PlatformException {
      packageInfo = 'Failed to get package info.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() => _packageInfo = packageInfo);
  }

  // Getting regional info for current device locale

  Future<void> initRegionalInfo() async {
    String regionalInfo;
    String localeInfo;
    try {
      regionalInfo = (await RegionalInfo.get()).toString();
      localeInfo = (await RegionalInfo.get(locale: 'ro_MD')).toString();
    } on PlatformException {
      regionalInfo = 'Failed to get device regional info.';
      localeInfo = 'Failed to get locale info.';
    }

    if (!mounted) return;

    setState(() {
      _regionalInfo = regionalInfo;
      _localeInfo = localeInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_packageInfo\n'),
              Text('Device Regional Info: $_regionalInfo\n'),
              Text('Locale "ro_MD" Info: $_localeInfo\n'),
            ],
          ),
        ),
      ),
    );
  }
}
