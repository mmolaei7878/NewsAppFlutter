import 'package:flutter/material.dart';
import 'package:flutter_music/Providers/NewsProvider.dart';

import 'package:provider/provider.dart';
import 'package:flutter_music/Screens/DescriptionsSaverScreen.dart';

class SavesListScreen extends StatelessWidget {
  static const routeNamed = 'SavesListScreen';
  Future<void> getData(BuildContext context) async {
    Provider.of<NewsProvider>(context, listen: false).fetchDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(context),
        builder: (ctx, snapShot) => Container(
          child: Consumer<NewsProvider>(
            builder: (ctx, news, child) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 5 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: news.saveList.length,
              itemBuilder: (ctx, i) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => DescriptionsSaverScreen(
                            author: news.saveList[i].author,
                            content: news.saveList[i].content,
                            date: news.saveList[i].date,
                            description: news.saveList[i].description,
                            id: news.saveList[i].id,
                            imageUrl: news.saveList[i].imageUrl,
                            title: news.saveList[i].title,
                            url: news.saveList[i].url,
                          )));
                },
                child: GridTile(
                  child: Image.network(
                    news.saveList[i].imageUrl,
                    fit: BoxFit.cover,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(news.saveList[i].title),
                    trailing: IconButton(
                        icon: Image.asset('assets/asset/save.png'),
                        onPressed: () {
                          Provider.of<NewsProvider>(context, listen: false)
                              .delete(news.saveList[i].author);
                          getData(context);
                        }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
