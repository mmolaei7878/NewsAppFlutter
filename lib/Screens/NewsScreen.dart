import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_music/Screens/SettingScreen.dart';
import 'package:flutter_music/Screens/bottomListView.dart';
import '../Providers/NewsProvider.dart';
import 'package:provider/provider.dart';
import 'DescriptionsScreen.dart';
import 'SavesListScreen.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Providers/languageProvider.dart';

class NewsScreen extends StatefulWidget {
  static const routeNamed = 'NewsScreen';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const api_key = '<<YOUR API KEY>>';
  Future fetch1;
  Future fetch2() {
    return Provider.of<NewsProvider>(context, listen: false).fetchData(
        'http://newsapi.org/v2/everything?q=tesla&from=2020-12-31&sortBy=publishedAt&apiKey=$api_key');
  }

  @override
  void initState() {
    fetch1 = fetch2();
    super.initState();
  }

  var fa = false;
  var load = false;
  @override
  Widget build(BuildContext context) {
    print('rebuild <<<<<<<<<<<<<<');
    final mqw = MediaQuery.of(context).size.width;
    final mqh = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              content: const Text('Do You Want To Exit'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('NO')),
                FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Yes')),
              ],
            ),
          );
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Container(
              color: Colors.blue[200],
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(SavesListScreen.routeNamed);
                    },
                    leading: const Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                    title: Text("${("DrawerMenu1".tr().toString())}"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .popAndPushNamed(SettingScreen.routeNamed);
                    },
                    leading: const Icon(
                      Icons.save,
                      color: Colors.black,
                    ),
                    title: Text("${("DrawerMenu2".tr().toString())}"),
                  ),
                ],
              ),
            ),
          ),
          body: FutureBuilder(
            future: fetch1,
            builder: (ctx, snapShot) => snapShot.connectionState ==
                    ConnectionState.waiting
                ? const Center(child: const CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: 45,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          height: 70,
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: IconButton(
                                    icon: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue[100],
                                      ),
                                      child: Icon(
                                        Icons.menu,
                                        size: 28,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                    onPressed: () {
                                      _scaffoldKey.currentState.openDrawer();
                                    }),
                              ),
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 60,
                                width: 60,
                                child: IconButton(
                                    icon: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue[100],
                                      ),
                                      child: Icon(
                                        Icons.search_rounded,
                                        size: 28,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                    onPressed: () {
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch());
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 70,
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            "${("title".tr().toString())}",
                            style: const TextStyle(
                                fontSize: 35, fontFamily: 'Baloo'),
                          ),
                        ),
                        Container(
                          child: Consumer<NewsProvider>(
                            builder: (ctx, prove, ch) => load
                                ? const Center(
                                    child: const CircularProgressIndicator(),
                                  )
                                : CarouselSlider.builder(
                                    itemCount: prove.news.length,
                                    itemBuilder: (ctx, i) => InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            DescriptionsScreen.routeNamed,
                                            arguments: prove.news[i].author);
                                      },
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: Hero(
                                                  tag: prove.news[i].id,
                                                  child: FadeInImage(
                                                    placeholder: AssetImage(
                                                        'assets/asset/noimage.png'),
                                                    image: NetworkImage(prove
                                                            .news[i].imageUrl ??
                                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              width: 330,
                                              height: 150,
                                              child: Container(
                                                width: 330,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(25),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25)),
                                                    color: Colors.black26),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        prove.news[i].author ??
                                                            'Nothing YEt',
                                                        softWrap: true,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        prove.news[i].title ??
                                                            'Nothing YET',
                                                        overflow:
                                                            TextOverflow.fade,
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    options: CarouselOptions(
                                        height: mqw * 1.0,
                                        initialPage: 0,
                                        autoPlay: true,
                                        autoPlayAnimationDuration:
                                            const Duration(seconds: 5),
                                        autoPlayCurve:
                                            Curves.fastLinearToSlowEaseIn,
                                        disableCenter: true,
                                        enlargeCenterPage: true,
                                        enableInfiniteScroll: true,
                                        scrollDirection: Axis.horizontal),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          height: mqh * 1.0,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                child: DefaultTabController(
                                  length: 4,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      isScrollable: true,
                                      tabs: [
                                        Tab(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await Provider.of<NewsProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchData(
                                                      'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$api_key');
                                              setState(() {});
                                            },
                                            child: Container(
                                                child: Text(
                                              "${("titleOne".tr().toString())}",
                                              style: TextStyle(
                                                  color: Colors.blue[200]),
                                            )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Provider.of<NewsProvider>(
                                                    context,
                                                    listen: false)
                                                .fetchData(
                                                    'http://newsapi.org/v2/everything?q=apple&from=2021-01-29&to=2021-01-29&sortBy=popularity&apiKey=$api_key');
                                            setState(() {});
                                          },
                                          child: Tab(
                                            child: Container(
                                              child: Text(
                                                "${("titleTwo".tr().toString())}",
                                                style: TextStyle(
                                                    color: Colors.blue[200]),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await Provider.of<NewsProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchData(
                                                      'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$api_key');
                                              setState(() {});
                                            },
                                            child: Container(
                                                child: Text(
                                              "${("titleThree".tr().toString())}",
                                              style: TextStyle(
                                                  color: Colors.blue[200]),
                                            )),
                                          ),
                                        ),
                                        Tab(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await Provider.of<NewsProvider>(
                                                      context,
                                                      listen: false)
                                                  .fetchData(
                                                      'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=$api_key');
                                              setState(() {});
                                            },
                                            child: Text(
                                              "${("titleFour".tr().toString())}",
                                              style: TextStyle(
                                                  color: Colors.blue[200]),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              BottomListView()
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
          ),
        ));
  }
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear_rounded), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final prove = Provider.of<NewsProvider>(context, listen: false)
        .news
        .where((element) => element.title.toLowerCase().startsWith(query))
        .toList();
    return ListView.builder(
        itemCount: prove.length,
        itemBuilder: (ctx, i) => ListTile(
              onTap: () {
                showResults(context);
                Navigator.of(context).pushNamed(DescriptionsScreen.routeNamed,
                    arguments: prove[i].author);
              },
              leading: Image.network(prove[i].imageUrl),
              title: Text(prove[i].title),
            ));
  }
}
