import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;

import 'dart:convert';

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
  List<NewsItem> _newsItems = [];

  List<NewsItem> get newsItems {
    return [..._newsItems];
  }

  Future<void> getNews() async {
    final response = await http.get(
        "https://learnappmaking.com/ex/news/articles/Apple?secret=CHWGk3OTwgObtQxGqdLvVhwji6FsYm95oe87o3ju");
    final newsData = json.decode(response.body) as Map<String, Object>;
    final articles = newsData["articles"] as List<dynamic>;
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
  }

  NewsItem findById(String id) {
    return _newsItems.firstWhere((newsItem) => newsItem.id == id);
  }
}
