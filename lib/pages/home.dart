/*
Author: Gerald Addo-Tetteh
Name: News App

This page shows the list of all news items
*/

//imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail.dart';
import '../providers/news_provider.dart';
import '../errors/http_error.dart' as errorHadler;

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

  @override
  Widget build(BuildContext context) {
    final newsItems =
        Provider.of<NewsProvider>(context, listen: false).newsItems;
    // depending on the error or loading status a particluar widget
    // is diplayed with the help of the ternary operator.
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _errorMessage != "no error"
            ? errorHadler.ErrorWidget(_errorMessage)
            : ListView.builder(
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  var _noAuthor = false;
                  if (newsItems[index].author == null ||
                      newsItems[index].author.length <= 0) {
                    _noAuthor = true;
                  }
                  // creates a list tile with a divider
                  return Column(
                    children: [
                      ListTile(
                        // the user is redirected to a different page
                        // when the list tile is taped
                        onTap: () => Navigator.of(context).pushNamed(
                            DetailPage.routeName,
                            arguments: newsItems[index].id),
                        title: Text(
                          newsItems[index].title,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Text(
                            _noAuthor ? "Unknown" : newsItems[index].author,
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: const Divider(),
                      ),
                    ],
                  );
                },
              );
  }
}
