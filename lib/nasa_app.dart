import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/views/Home/home.dart';
import 'package:nasa_app/views/PhotosList/photos_list.dart';

class NasaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {'/': (context) => Home(), '/photos': (context) => PhotosList()},
    );
  }
}
