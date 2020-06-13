/*
Author: Gerald Addo-Tetteh
Name: News App

This page shows the list of all news items
*/

//imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';
import '../errors/http_error.dart' as errorHadler;
import '../widgets/news_item_builder.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        // The preferred size is used to develop an
        // appbar with custom height.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 15.0,
                  bottom: 3.0,
                ),
                child: Text(
                  "News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      // custom widget
      body: NewsListItems(),
    );
  }
}

/* 
This widgets generates the list of news items
Data is collected asynchronously, 
a loading screen is diplayed until the data has been retrieved
*/
class NewsListItems extends StatefulWidget {
  @override
  _NewsListItemsState createState() => _NewsListItemsState();
}

class _NewsListItemsState extends State<NewsListItems> {
  var _isLoading = true;
  var _isint = true;
  var _errorMessage = "no error";

  // fetching data from sever
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isint) {
      try {
        await Provider.of<NewsProvider>(context, listen: false)
            .getNews()
            .then((_) => setState(() => _isLoading = false));
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
    _isint = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<NewsProvider>(context, listen: false).getNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsItems = Provider.of<NewsProvider>(context).newsItems;
    // depending on the error or loading status a particluar widget
    // is diplayed with the help of the ternary operator.
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _errorMessage != "no error"
            ? errorHadler.ErrorWidget(_errorMessage)
            : RefreshIndicator(
                child: NewsItemBuilder(newsItems: newsItems),
                onRefresh: () => _refreshData(context),
              );
  }
}
