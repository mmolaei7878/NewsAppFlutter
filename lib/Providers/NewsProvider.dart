import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DBHelper.dart';

class News {
  final String id;
  final Map<String, String> source;
  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String content;
  final String url;
  News(
      {@required this.id,
      this.author,
      this.content,
      this.date,
      this.description,
      this.imageUrl,
      this.source,
      this.title,
      this.url});
}

class NewsProvider with ChangeNotifier {
  List<News> _news = [
    News(
        id: '',
        author: '',
        content: '',
        date: '                    ',
        description: '',
        imageUrl: '',
        source: {},
        title: '',
        url: '')
  ];
  List<News> get news {
    return [..._news];
  }

  Future<void> fetchData(String geturl) async {
    try {
      final url = geturl;
      final resposne = await http.get(url);
      final extractedData = json.decode(resposne.body) as Map<String, dynamic>;
      final List<News> loadedData = [];

      (extractedData['articles'] as List<dynamic>)
          .map((e) => loadedData.add(News(
                id: DateTime.now().toString(),
                author: e['author'],
                content: e['content'],
                date: e['publishedAt'],
                description: e['description'],
                title: e['title'],
                source: {'id': '', 'name': ''},
                url: e['url'],
                imageUrl: e['urlToImage'] == null
                    ? 'https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg'
                    : e['urlToImage'],
              )))
          .toList();

      _news = loadedData;
    } catch (error) {
      print(error);
    }
  }

  News findByAuthor(String author) {
    return _news.firstWhere((ele) => ele.author == author);
  }

  List<News> _saveList = [];
  List<News> get saveList {
    return [..._saveList];
  }

  void addtoSaves(String author) {
    final newNews = _news.firstWhere((element) => element.author == author);

    DBHelper.insert({
      'id': newNews.id,
      'author': newNews.author,
      'title': newNews.title,
      'description': newNews.description,
      'imageUrl': newNews.imageUrl,
      'date': newNews.date,
      'content': newNews.content,
      'url': newNews.url
    });

    notifyListeners();
  }

  Future<void> fetchDataBase() async {
    final dataList = await DBHelper.fetchData();
    _saveList = dataList
        .map((e) => News(
            id: e['id'],
            author: e['author'],
            content: e['content'],
            date: e['date'],
            description: e['description'],
            imageUrl: e['imageUrl'],
            title: e['title'],
            url: e['url']))
        .toList();
    notifyListeners();
  }

  Future<void> delete(String author) async {
    DBHelper.delete(author);
    notifyListeners();
  }
}
