import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail.dart';
import '../providers/news_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
      body: NewsListItems(),
    );
  }
}

class NewsListItems extends StatefulWidget {
  @override
  _NewsListItemsState createState() => _NewsListItemsState();
}

class _NewsListItemsState extends State<NewsListItems> {
  var _isLoading = true;
  var _isint = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isint) {
      Provider.of<NewsProvider>(context, listen: false)
          .getNews()
          .then((_) => setState(() => _isLoading = false));
    }
    _isint = false;
  }

  @override
  Widget build(BuildContext context) {
    final newsItems =
        Provider.of<NewsProvider>(context, listen: false).newsItems;
    // final mediaQuery = MediaQuery.of(context).viewPadding.top;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: newsItems.length,
            itemBuilder: (context, index) {
              var _noAuthor = false;
              if (newsItems[index].author == null ||
                  newsItems[index].author.length <= 0) {
                _noAuthor = true;
              }
              return Column(
                children: [
                  ListTile(
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
