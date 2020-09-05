import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/news_deatails.dart';
import 'package:news_app/services/api.dart';

import 'models/news_model.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  TabController _tabController;
  List<News> news;
  bool hasArrived = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    getNews();
  }

  Future<void> getNews() async {
    news = await ApiCall().makeCall();
    setState(() {
      hasArrived = true;
    });
  }

  List<Widget> tabs = [
    Tab(
      child: Text("Trending"),
    ),
    Tab(
      child: Text("World News"),
    ),
    Tab(
      child: Text("World News"),
    ),
    Tab(
      child: Text("World News"),
    ),
    Tab(
      child: Text("World News"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: hasArrived
          ? SingleChildScrollView(
              child: Column(
                children: news.map((e) => NewsCard(news: e)).toList(),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int value) => setState(() => currentIndex = value),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: SizedBox.shrink()),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), title: SizedBox.shrink()),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: SizedBox.shrink())
          ]),
    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({Key key, @required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size DevSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => NewsDetails(
                  news: this.news,
                ))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(color: Colors.white30, boxShadow: [
              // BoxShadow(
              //   blurRadius: 5,
              //   color: Colors.white54,
              //   spreadRadius: 8,
              //   offset: Offset(0,3)
              // )
            ]),
            height: 100,
            child: Row(
              children: [
                Container(
                    height: double.infinity,
                    width: DevSize.width / 3,
                    child: Image.network(
                      news.imgUrl,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      news.title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
