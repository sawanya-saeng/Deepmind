import 'dart:async';
import 'dart:io';

import 'package:deepmind/providers/PlayProvider.dart';
import 'package:deepmind/providers/StatProvider.dart';
import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlayPage createState() => _PlayPage();
}

class _PlayPage extends State<PlayPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final List<Map<String, dynamic>> buttons = [
    {
      "name": "blue",
      "title": "อยาก",
      "primary": 0xff0062ff,
      "optional": 0xff0049bf,
      "point": 1
    },
    {
      "name": "red",
      "title": "โทสะ",
      "primary": 0xffe01d1d,
      "optional": 0xffb41111,
      "point": 1
    },
    {
      "name": "green",
      "title": "หลง",
      "primary": 0xff51d300,
      "optional": 0xff3ea001,
      "point": 1
    },
    {
      "name": "yellow",
      "title": "รู้",
      "primary": 0xffffb100,
      "optional": 0xffc38905,
      "point": 1
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final PlayProvider playProvider = Provider.of<PlayProvider>(context);
    final StatProvider statProvider = Provider.of<StatProvider>(context);
    return Scaffold(
      body: Container(
        color: Color(0xff11BCB5),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 75,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    color: Color(0xff11BCB5),
                    child: Text(
                      'ตอนนี้คุณรู้สึกอย่างไร ?',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white)),
                ),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          padding:
                              EdgeInsets.only(top: 70, left: 30, right: 30),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(4, (index) {
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      if (!playProvider.getNumberStatus(
                                              buttons[index]["name"]) &&
                                          playProvider.isPlay()) {
                                        playProvider.setNumberStatus(
                                            buttons[index]["name"], true);
                                        playProvider.addPointToKey(
                                            buttons[index]["name"],
                                            buttons[index]["point"]);
                                        new Timer(new Duration(seconds: 1), () {
                                          playProvider.setNumberStatus(
                                              buttons[index]["name"], false);
                                        });
                                      }
                                    },
                                    child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                            color: playProvider.getNumberStatus(
                                                    buttons[index]["name"])
                                                ? Color(
                                                    buttons[index]["optional"])
                                                : Color(
                                                    buttons[index]["primary"]),
                                            border: Border.all(
                                                width: 5.0,
                                                color: Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        alignment: Alignment.center,
                                        child: Text(
                                          buttons[index]["title"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35),
                                        )),
                                  ),
                                  IgnorePointer(
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 200),
                                      opacity: playProvider.getNumberStatus(
                                              buttons[index]["name"])
                                          ? 1
                                          : 0,
                                      child: Container(
                                        padding: EdgeInsets.all(25),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          "+${buttons[index]["point"]}",
                                          style: TextStyle(fontSize: 40),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            !playProvider.isPlay()
                                ? GestureDetector(
                                    onTap: () {
                                      playProvider.setCountDownTime();
                                      playProvider.reset();
                                      playProvider.play();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        width: 250,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'เริ่มเล่น',
                                          style: TextStyle(
                                              color: Color(0xff00807A),
                                              fontSize: 30),
                                        )),
                                  )
                                : Container(
                                    child: CountdownFormatted(
                                      duration: playProvider.getCountdown(),
                                      onFinish: () async {
                                        playProvider.stop();
                                        playProvider.saveScore();
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                content: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff00746F),
                                                    border: Border.all(
                                                        width: 8.0,
                                                        color:
                                                            Color(0xff00746F)),
                                                  ),
                                                  alignment: Alignment.center,
                                                  height: 400,
                                                  width: 400,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color:
                                                            Color(0xff00746F),
                                                        height: 60,
                                                        child: Text(
                                                          'แต้มที่ได้ในครั้งนี้',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 30),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                              child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                "ให้ผู้เล่นรับรู้ว่ามีความร้สึกแบบใดในใจ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                  "เป็นเวลา ${playProvider.getCoolDown().toString()} วินาที",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              Text(
                                                                  "โดยให้ทำภายใจ ไม่ต้องกดปุ่ม",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              Spacer(),
                                                              Container(
                                                                child:
                                                                    CountdownFormatted(
                                                                  duration: playProvider.getCoolDown(),
                                                                  onFinish: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  builder: (BuildContext
                                                                          context,
                                                                      String
                                                                          time) {
                                                                    return Container(
                                                                      child: Text(
                                                                          'เหลือเวลาอีก: $time',
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                content: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff00746F),
                                                    border: Border.all(
                                                        width: 8.0,
                                                        color:
                                                            Color(0xff00746F)),
                                                  ),
                                                  alignment: Alignment.center,
                                                  height: 400,
                                                  width: 400,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color:
                                                            Color(0xff00746F),
                                                        height: 60,
                                                        child: Text(
                                                          'แต้มที่ได้ในครั้งนี้',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 30),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          color: Colors.white,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xffFF0000)),
                                                              height: 150,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                playProvider
                                                                    .getScore()
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        80),
                                                              )),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          playProvider.reset();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          color:
                                                              Color(0xff00746F),
                                                          height: 60,
                                                          child: Text(
                                                            'ตกลง',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 30),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).then((value) {
                                          statProvider.loadStat();
                                        });
                                      },
                                      builder:
                                          (BuildContext ctx, String remaining) {
                                        return Container(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Color(0xff00807A),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            width: 250,
                                            alignment: Alignment.center,
                                            child: Text(
                                              remaining,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30),
                                            ));
                                      },
                                    ),
                                  ),
                            playProvider.isPlay()
                                ? GestureDetector(
                                    onTap: () {
                                      playProvider.stop();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.replay,
                                          color: Colors.white, size: 50),
                                    ),
                                  )
                                : Container()
                          ],
                        )),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
