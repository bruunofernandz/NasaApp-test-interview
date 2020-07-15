import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/database/db.dart';
import 'package:nasa_app/services/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DatabaseCreator().initializeDatabase();
      Api().getApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7159c1),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: 50,
                        color: Color(0xFFDC935B),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome to the space",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "You can see some photos directly, at Nasa. So, click on Get Started",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  Center(
                    child: Image.asset("assets/images/nasa.png"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/photos");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFDC935B),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              offset: Offset(0, 5),
                              color: Color(0xFFDC935B),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Get Started",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
