import 'package:flutter/material.dart';
import 'DescriptionsScreen.dart';
import 'package:provider/provider.dart';
import '../Providers/NewsProvider.dart';

class BottomListView extends StatefulWidget {
  @override
  _BottomListViewState createState() => _BottomListViewState();
}

class _BottomListViewState extends State<BottomListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Consumer<NewsProvider>(
        builder: (ctx, prove, _) => prove.news == null
            ? Image.asset('assets/asset/internet.png')
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        DescriptionsScreen.routeNamed,
                        arguments: prove.news.last.author);
                  },
                  child: Container(
                    height: 120,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: prove.news.last.imageUrl == null
                            ? Image.asset('assets/asset/internet.png')
                            : Image.network(
                                prove.news.last.imageUrl,
                                height: 120,
                              ),
                        title: Text(prove.news.last.title == null
                            ? ''
                            : prove.news.last.title),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
