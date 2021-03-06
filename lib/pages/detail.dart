/*
Author: Gerald Addo-Tetteh
Name: News App

This page shows the details about the news items
*/

// imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';

/*
This widget recieves the id of the news item
and uses the id to locate the news item from
the provider file and renders the details of the item
*/

class DetailPage extends StatelessWidget {
  static const routeName = "/detail-page";
  final defaultImage =
      "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";
  var _noImage = false;
  var _noAuthor = false;
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final newsItem =
        Provider.of<NewsProvider>(context, listen: false).findById(id);
    // error handling for missing data
    if (newsItem.imageUrl == null || newsItem.imageUrl.length <= 0) {
      _noImage = true;
    }
    if (newsItem.author == null || newsItem.author.length <= 0) {
      _noAuthor = true;
    }
    /*
    The widget shows the tile, author and image
    of the news item.
    */
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          newsItem.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // the expanded widget helps to maintain the height of the
        // contents regardless of the screen size.
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Image.network(
              _noImage ? defaultImage : newsItem.imageUrl,
              fit: BoxFit.cover,
              // fades in the image once it is retrieved
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              // aligns the elements in the column from left to right
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    newsItem.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    _noAuthor ? "Unknown" : newsItem.author,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  newsItem.text,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
