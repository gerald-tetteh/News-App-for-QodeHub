/*
Author: Gerald Addo-Tetteh
Name: News App

This is the provider file which
controls the app wide logic.
*/

import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../errors/http_error.dart';

// A news item class to define how a
// news item should look
class NewsItem {
  final String title;
  final String text;
  final String imageUrl;
  final String author;
  final String publisher;
  final String id;

  NewsItem(
      {this.author,
      this.id,
      this.imageUrl,
      this.publisher,
      this.text,
      this.title});
}

class NewsProvider with ChangeNotifier {
  // a list to contain all news items
  List<NewsItem> _newsItems = [];

  // getter for news items to prevent list
  // from being altered outside this file
  List<NewsItem> get newsItems {
    return [..._newsItems];
  }

  // fetches data from server
  Future<void> getNews() async {
    // error handeling with try catch
    try {
      final response = await http.get(
          "https://learnappmaking.com/ex/news/articles/Apple?secret=CHWGk3OTwgObtQxGqdLvVhwji6FsYm95oe87o3ju");
      final newsData = json.decode(response.body) as Map<String, Object>;
      final articles = newsData["articles"] as List<dynamic>;
      // convert data to a list of NewsItems
      _newsItems = articles.map((article) {
        return NewsItem(
          id: article["id"],
          title: article["title"],
          text: article["text"],
          imageUrl: article["image"],
          author: article["author"],
          publisher: article["publisher"],
        );
      }).toList();
    } catch (e) {
      // any errors in the try block is caught in this block
      throw HttpError("Could not load data try again later");
    }
  }

  NewsItem findById(String id) {
    return _newsItems.firstWhere((newsItem) => newsItem.id == id);
  }
}
