import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tripbyla/navigator/tab_navigator.dart';
import 'package:http/http.dart' as http;
import 'package:tripbyla/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter之旅',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}