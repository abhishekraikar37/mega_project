import 'dart:convert';

import 'package:chaleno/chaleno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_scraper/results.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int option = 0;

  Future<Response> a() async {
    List<Map> reviews = [];
    var parser = await Chaleno().load(
        'https://www.opentable.com/r/hakkasan-abu-dhabi?originId=ebe358b2-b220-47e0-a2be-0e63d5036413&corrid=ebe358b2-b220-47e0-a2be-0e63d5036413');
    Result result = parser!
        .getElementById('review-body-container-OT-986509-2371777-160145534366');
    List<Result> results = parser
        .getElementsByClassName('reviewBodyContainer oc-reviews-8107696f');
    'maybe';
    var obj = new Map<String, dynamic>();
    for (int i = 0; i < results.length; i++) {
      String temp = results[i].text!;
      var map = new Map<String, dynamic>();
      map['review'] = temp;
      reviews.add(map);
    }
    obj['restaurant-reviews'] = reviews;
    String ans = jsonEncode(obj);
    var url =
        Uri.parse('https://project-restaurant-review-sa.herokuapp.com/predict');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: ans);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Response r = await Response.fromJson(jsonDecode(response.body));
    return r;
  }

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xff2d2c2c);
    Color text;
    return Scaffold(
      // backgroundColor: Color(0xFF252c49),
      appBar: AppBar(
        title: Text(
          'Review Analyzer',
          style: TextStyle(
              color: Color(0xff2d2c2c),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xffff9000),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff2d2c2c),
                    border: Border.all(
                      color: Color(0xffff9000),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Choose the source',
                          style: TextStyle(
                            color: Color(0xffff9000),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              color: option == 1
                                  ? Colors.black54
                                  : Color(0xff2d2c2c),
                              //color: Colors.black54,
                              elevation: 80,
                              child: Text(
                                'OpenTable',
                                style: TextStyle(
                                  color: Color(0xffff9000),
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  option = 1;
                                });
                                a();
                              },
                              height: 50,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  //color: Color(0xFFFCC001),
                                  color: Color(0xffff9000),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            MaterialButton(
                              //color: Color(0xff2d2c2c),
                              color: option == 2
                                  ? Colors.black54
                                  : Color(0xff2d2c2c),
                              child: Text(
                                'Zomato',
                                style: TextStyle(
                                  color: Color(0xffff9000),
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  option = 2;
                                });
                                a();
                              },
                              height: 50,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Color(0xffff9000),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            MaterialButton(
                              //color: Color(0xff2d2c2c),
                              color: option == 3
                                  ? Colors.black54
                                  : Color(0xff2d2c2c),
                              child: Text(
                                'Website',
                                style: TextStyle(
                                  color: Color(0xffff9000),
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  option = 3;
                                });
                                a();
                              },
                              height: 50,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  //color: Color(0xFFFCC001),
                                  color: Color(0xffff9000),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  child: MaterialButton(
                    //color: Color(0xff2d2c2c),
                    color: Color(0xff2d2c2c),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xffff9000),
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () async {
                      Response r = await a();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(
                            x: r.pcount,
                            y: r.ncount,
                            pp: r.ppercent,
                            np: r.npercent,
                          ),
                        ),
                      );
                    },
                    height: 50,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        //color: Color(0xFFFCC001),
                        color: Color(0xffff9000),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Response {
  int pcount;
  int ncount;
  double ppercent;
  double npercent;
  Response(
      {required this.pcount,
      required this.ncount,
      required this.ppercent,
      required this.npercent});
  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
        pcount: json['positive'],
        ncount: json['negative'],
        ppercent: json['positive-percentage'],
        npercent: json['negative-percentage']);
  }
}
