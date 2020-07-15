import 'package:flutter/material.dart';
import 'package:nasa_app/models/nasa_model.dart';

class Details extends StatefulWidget {
  final NasaModel model;

  Details({this.model});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${widget.model.hdurl}"),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 120, horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "${widget.model.title}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.model.date}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                  color: Color(0xFFDC935B),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "(Scrollable)",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(255, 255, 255, .51)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          "${widget.model.explanation}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, .51)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
