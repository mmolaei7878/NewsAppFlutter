import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/NewsProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionsScreen extends StatelessWidget {
  static const routeNamed = 'DescriptionsScreen';

  @override
  Widget build(BuildContext context) {
    final mqw = MediaQuery.of(context).size.width;
    final mqh = MediaQuery.of(context).size.height;
    final id = ModalRoute.of(context).settings.arguments;
    final foundedItem =
        Provider.of<NewsProvider>(context, listen: false).findByAuthor(id);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            expandedHeight: mqh * 0.4,
            pinned: true,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Provider.of<NewsProvider>(context, listen: false)
                        .addtoSaves(foundedItem.author);
                  },
                  icon: Image.asset(
                    'assets/asset/save.png',
                    width: 40,
                    height: 40,
                  )),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    child: Hero(
                      tag: foundedItem.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.network(
                          foundedItem.imageUrl,
                          height: mqh * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 15,
                      left: 15,
                      height: 70,
                      width: mqw * 0.7,
                      child: Container(
                        width: mqw * 0.7,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          foundedItem.title,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Baloo',
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      )),
                  width: double.infinity,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: mqw * 1.0,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: mqw * 0.3,
                                child: Card(
                                  color: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    child: Text(
                                      foundedItem.author,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: ''),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: mqw * 0.3,
                                child: Card(
                                  color: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: mqw * 0.3,
                                    height: 50,
                                    child: Text(
                                      (foundedItem.date
                                                  .replaceRange(10, 20, ''))
                                              .toString() ??
                                          'Nothing YET',
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: ''),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: mqw * 0.3,
                                child: Card(
                                    color: Colors.blue[100],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FlatButton(
                                        onPressed: () async {
                                          await launch(
                                              Uri.encodeFull(foundedItem.url));
                                        },
                                        child: Image.asset(
                                          'assets/asset/internet.png',
                                          color: Colors.black,
                                        ))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: mqw * 1.0,
                          child: Text(
                            foundedItem.title,
                            style: TextStyle(
                                fontFamily: '',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: mqw * 1.0,
                          child: Text(
                            foundedItem.description,
                            style: TextStyle(fontFamily: '', fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: mqw * 1.0,
                          child: Text(
                            'Content',
                            style: TextStyle(fontFamily: '', fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: mqw * 1.0,
                          child: Text(
                            foundedItem.content,
                            style: TextStyle(fontFamily: '', fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
