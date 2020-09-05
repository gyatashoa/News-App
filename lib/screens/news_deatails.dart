import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';

class NewsDetails extends StatelessWidget {
  final News news;

  const NewsDetails({Key key, this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size Devsize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
            ),
            // primary: true,
            expandedHeight: Devsize.height / 3,
            flexibleSpace: Container(
              height: double.infinity,
              child: Image.network(
                news.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Text(news.content),
          )
        ],
      ),
    );
  }
}
