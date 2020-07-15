import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:nasa_app/database/db.dart';
import 'package:nasa_app/models/nasa_model.dart';
import 'package:nasa_app/services/api.dart';
import 'package:nasa_app/views/Details/details.dart';

class PhotosList extends StatefulWidget {
  @override
  _PhotosListState createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  List<NasaModel> alterList = List<NasaModel>();
  List<NasaModel> list = List<NasaModel>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 3), (x) => refreshNum);

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    DatabaseCreator().getPhoto().then((value) {
      setState(() {
        alterList.addAll(value);
        list = alterList;
      });
    });

    _scrollController = ScrollController();
  }

  Future<void> _handleRefresh() async {
    Timer(const Duration(seconds: 3), () {
      Api().getApi();
    });

    DatabaseCreator().getPhoto().then((value) {
      setState(() {
        alterList.clear();
        alterList.addAll(value);
        list = alterList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/avatar.jpg"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("James Rodfold Willians",
                            style: TextStyle(
                                color: Color(0xFF121212),
                                fontWeight: FontWeight.bold)),
                        Text(
                          "Cientist",
                          style: TextStyle(color: Color(0xFF999999)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 120,
                              child: FlatButton(
                                onPressed: () {},
                                color: Color(0xFF597CC1),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: 70,
                              child: FlatButton(
                                  onPressed: () {},
                                  color: Color(0xFF599CC1),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Busque pelo título da imagem...",
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  text = text.toLowerCase();

                  setState(() {
                    list = alterList.where((element) {
                      var search = element.title.toLowerCase();
                      var date = element.date.toLowerCase();

                      if (search.contains(text))
                        return search.contains(text);
                      else
                        return date.contains(text);
                    }).toList();
                  });
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: LiquidPullToRefresh(
                key: _refreshIndicatorKey,
                onRefresh: _handleRefresh,
                backgroundColor: Colors.white,
                height: 80,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: card(context, list[index].hdurl,
                              list[index].title, list[index].date, list[index]),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget card(BuildContext context, String imageName, String title, String date,
    NasaModel model) {
  return Container(
    width: MediaQuery.of(context).size.width * .9,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
          image: NetworkImage("$imageName"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, .8), BlendMode.colorBurn)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Text(
          "$date",
          style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .75,
          height: 45,
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      model: model,
                    ),
                  ));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0xFF7159c1),
            child: Text("Details",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
  );
}
