import 'package:flutter/material.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

import './pages/home.dart';
import './pages/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
