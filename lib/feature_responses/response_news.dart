class ResponseListNews {
  ResponseListNews({required this.listNews});

  List<ResponseNews> listNews;

  factory ResponseListNews.fromJson(Map<String, dynamic> json) {
    List<ResponseNews> listNews = [];

    for (var news in json['news']) {
      listNews.add(ResponseNews.fromJson(news));
    }

    return ResponseListNews(listNews: listNews);
  }
}

class ResponseNews {
  ResponseNews({
    required this.author,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.publishedAt,
  });

  String author;
  String title;
  String description;
  String imageUrl;
  String url;
  String publishedAt;

  factory ResponseNews.fromJson(Map<String, dynamic> json) {
    return ResponseNews(
      title: json['title'],
      author: json['author'],
      imageUrl: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      description: json['description'],
    );
  }
}
