import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionsSaverScreen extends StatelessWidget {
  static const routeNamed = 'DescriptionsSaverScreen';
  final String id;

  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String content;
  final String url;
  const DescriptionsSaverScreen(
      {this.id,
      this.author,
      this.content,
      this.date,
      this.description,
      this.imageUrl,
      this.title,
      this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            expandedHeight: 400,
            pinned: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(
                      imageUrl,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      height: 70,
                      width: 350,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: '',
                            backgroundColor: Colors.black45),
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
                  width: 350,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: 420,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: 120,
                                child: Card(
                                  color: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    child: Text(
                                      author,
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
                                width: 120,
                                child: Card(
                                  color: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 120,
                                    height: 50,
                                    child: Text(
                                      (date.replaceRange(10, 20, ''))
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
                                width: 120,
                                child: Card(
                                    color: Colors.blue[100],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FlatButton(
                                        onPressed: () async {
                                          await launch(Uri.encodeFull(url));
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
                          width: 340,
                          child: Text(
                            title,
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
                          width: 340,
                          child: Text(
                            description,
                            style: TextStyle(fontFamily: '', fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 340,
                          child: Text(
                            'Content',
                            style: TextStyle(fontFamily: '', fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 340,
                          child: Text(
                            content,
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
