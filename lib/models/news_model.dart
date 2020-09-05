class News {
  final DateTime date;
  final String desc;
  final String title;
  final String author;
  final String imgUrl;
  final String source;
  final String content;
  final String url;

  News._(
      {this.date,
      this.desc,
      this.title,
      this.author,
      this.imgUrl,
      this.source,
      this.content,
      this.url});

  factory News(var obj) {
    return News._(
       date:DateTime.parse(obj['publishedAt']),
        desc: obj['description'],
        url: obj['url'],
        imgUrl: obj['urlToImage'],
        content: obj['content'],
        author: obj['author'],
        source: obj['source']['name'],
        title: obj['title']
    );
  }
}
