/*
Author: Gerald Addo-Tetteh
Name: News App
*/

// imports
import 'package:flutter/material.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import './pages/detail.dart';

void main() {
  runApp(MyApp());
}

//Main widget which controlls the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // providers the news items to all child widgets
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MaterialApp(
        title: 'News',
        home: Home(),
        routes: {
          DetailPage.routeName: (ctx) => DetailPage(),
        },
      ),
    );
  }
}
