import 'package:flutter/material.dart';

import '../pages/detail.dart';
import '../providers/news_provider.dart';

class NewsItemBuilder extends StatelessWidget {
  const NewsItemBuilder({
    Key key,
    @required this.newsItems,
  }) : super(key: key);

  final List<NewsItem> newsItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              onTap: () => Navigator.of(context).pushNamed(DetailPage.routeName,
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
