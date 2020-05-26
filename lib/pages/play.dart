import 'dart:async';
import 'dart:io';

import 'package:deepmind/providers/PlayProvider.dart';
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
    },
    {
      "name": "red",
      "title": "โทสะ",
      "primary": 0xffe01d1d,
      "optional": 0xffb41111,
    },
    {
      "name": "green",
      "title": "หลง",
      "primary": 0xff51d300,
      "optional": 0xff3ea001,
    },
    {
      "name": "yellow",
      "title": "รู้",
      "primary": 0xffffb100,
      "optional": 0xffc38905,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final PlayProvider playProvider = Provider.of<PlayProvider>(context);
    return Scaffold(
      body: Container(
        color: Color(0xff11BCB5),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  height: 75,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  color: Color(0xff11BCB5),
                  child: Text(
                    'ตอนนี้คุณรู้สึกอย่างไร ?',
                    style: TextStyle(color: Colors.white, fontSize: 30),
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
                          padding: EdgeInsets.only(
                              top: 20, left: 50, right: 50, bottom: 50),
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          children: List.generate(4, (index) {
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      if (!playProvider.getNumberStatus(buttons[index]["name"])) {
                                        playProvider.setNumberStatus(
                                            buttons[index]["name"], true);
                                        new Timer(new Duration(seconds: 1), () {playProvider.setNumberStatus(
                                              buttons[index]["name"], false);
                                        });
                                      }
                                    },
                                    child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                            color: playProvider.getNumberStatus(buttons[index]["name"])
                                                ? Color(buttons[index]["optional"])
                                                : Color(buttons[index]["primary"]),
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
                                      opacity: playProvider.getNumberStatus(buttons[index]["name"]) ? 1 : 0,
                                      child: Container(
                                        padding: EdgeInsets.all(25),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          "+1",
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
                            !playProvider.isPlay() ? GestureDetector(
                              onTap: () {
                                playProvider.play();
                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  width: 250,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'เริ่มเล่น',
                                    style: TextStyle(
                                        color: Color(0xff00807A), fontSize: 30),
                                  )),
                            ):Container(
                              child: CountdownFormatted(
                                duration: playProvider.getCountdown(),
                                onFinish: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xff00746F),
                                              border: Border.all(
                                                  width: 8.0, color: Color(0xff00746F)),
                                            ),
                                            alignment: Alignment.center,
                                            height: 400,
                                            width: 400,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  color: Color(0xff00746F),
                                                  height: 60,
                                                  child: Text(
                                                    'แต้มที่ได้ในครั้งนี้',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.white,
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Color(0xffFF0000)),
                                                        height: 150,
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          '20',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 80),
                                                        )),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    color: Color(0xff00746F),
                                                    height: 60,
                                                    child: Text(
                                                      'ตกลง',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                builder: (BuildContext ctx, String remaining) {
                                  return Container(
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xff00807A),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      width: 250,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${remaining}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ));
                                },
                              ),
                            ),
                            playProvider.isPlay() ? GestureDetector(
                              onTap: () {
                                playProvider.stop();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: Icon(Icons.replay,
                                    color: Colors.white, size: 50),
                              ),
                            ):Container()
                          ],
                        )),
                  ],
                )),
//                color: Colors.red,
//                child: ListView(
//                  padding: EdgeInsets.zero,
//                  children: <Widget>[
////                    Row(
////                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      children: <Widget>[
////                        Container(
////                          child: Stack(
////                            alignment: Alignment.center,
////                            children: <Widget>[
////                              GestureDetector(
////                                onTap: () {
////                                  if (!playProvider.getNumberStatus("blue")) {
////                                    playProvider.setNumberStatus("blue", true);
////                                    new Timer(new Duration(seconds: 1), () {
////                                      playProvider.setNumberStatus(
////                                          "blue", false);
////                                    });
////                                  }
////                                },
////                                child: AnimatedContainer(
////                                    duration: Duration(milliseconds: 200),
////                                    decoration: BoxDecoration(
////                                        color:
////                                            playProvider.getNumberStatus("blue")
////                                                ? Color(0xff003993)
////                                                : Color(0xff0062FF),
////                                        border: Border.all(
////                                            width: 5.0, color: Colors.white),
////                                        borderRadius: BorderRadius.all(
////                                            Radius.circular(30))),
////                                    height: maxHeight/3.75,
////                                    width: maxHeight/3.75,
////                                    alignment: Alignment.center,
////                                    child: Text(
////                                      'อยาก',
////                                      style: TextStyle(
////                                          color: Colors.white, fontSize: 35),
////                                    )),
////                              ),
////                              IgnorePointer(
////                                child: AnimatedOpacity(
////                                  duration: Duration(milliseconds: 200),
////                                  opacity: playProvider.getNumberStatus("blue")
////                                      ? 1
////                                      : 0,
////                                  child: Container(
////                                    padding: EdgeInsets.all(25),
////                                    decoration: BoxDecoration(
////                                      shape: BoxShape.circle,
////                                      color: Colors.white,
////                                    ),
////                                    child: Text(
////                                      "+1",
////                                      style: TextStyle(fontSize: 80),
////                                    ),
////                                  ),
////                                ),
////                              ),
////                            ],
////                          ),
////                        ),
////                        Container(
////                          child: Stack(
////                            alignment: Alignment.center,
////                            children: <Widget>[
////                              GestureDetector(
////                                onTap: () {
////                                  if (!playProvider.getNumberStatus("red")) {
////                                    playProvider.setNumberStatus("red", true);
////                                    new Timer(new Duration(seconds: 1), () {
////                                      playProvider.setNumberStatus(
////                                          "red", false);
////                                    });
////                                  }
////                                },
////                                child: AnimatedContainer(
////                                    duration: Duration(milliseconds: 200),
////                                    decoration: BoxDecoration(
////                                        color:
////                                            playProvider.getNumberStatus("red")
////                                                ? Color(0xff8b0000)
////                                                : Color(0xffd91a1a),
////                                        border: Border.all(
////                                            width: 5.0, color: Colors.white),
////                                        borderRadius: BorderRadius.all(
////                                            Radius.circular(30))),
////                                    height: maxHeight/4,
////                                    width: maxHeight/4,
////                                    alignment: Alignment.center,
////                                    child: Text(
////                                      'โทสะ',
////                                      style: TextStyle(
////                                          color: Colors.white, fontSize: 35),
////                                    )),
////                              ),
////                              IgnorePointer(
////                                child: AnimatedOpacity(
////                                  duration: Duration(milliseconds: 200),
////                                  opacity: playProvider.getNumberStatus("red")
////                                      ? 1
////                                      : 0,
////                                  child: Container(
////                                    padding: EdgeInsets.all(25),
////                                    decoration: BoxDecoration(
////                                      shape: BoxShape.circle,
////                                      color: Colors.white,
////                                    ),
////                                    child: Text(
////                                      "+1",
////                                      style: TextStyle(fontSize: 80),
////                                    ),
////                                  ),
////                                ),
////                              ),
////                            ],
////                          ),
////                        ),
////                      ],
////                    ),
////                    Row(
////                      children: <Widget>[
////                        Expanded(
////                          flex: 18,
////                          child: Container(
////                            child: Stack(
////                              alignment: Alignment.center,
////                              children: <Widget>[
////                                GestureDetector(
////                                  onTap: () {
////                                    if (!playProvider
////                                        .getNumberStatus("green")) {
////                                      playProvider.setNumberStatus(
////                                          "green", true);
////                                      new Timer(new Duration(seconds: 1), () {
////                                        playProvider.setNumberStatus(
////                                            "green", false);
////                                      });
////                                    }
////                                  },
////                                  child: AnimatedContainer(
////                                      duration: Duration(milliseconds: 200),
////                                      decoration: BoxDecoration(
////                                          color: playProvider
////                                                  .getNumberStatus("green")
////                                              ? Color(0xff379000)
////                                              : Color(0xff51d300),
////                                          border: Border.all(
////                                              width: 5.0, color: Colors.white),
////                                          borderRadius: BorderRadius.all(
////                                              Radius.circular(30))),
////                                      height: 190,
////                                      width: 200,
////                                      alignment: Alignment.center,
////                                      child: Text(
////                                        'หลง',
////                                        style: TextStyle(
////                                            color: Colors.white, fontSize: 35),
////                                      )),
////                                ),
////                                IgnorePointer(
////                                  child: AnimatedOpacity(
////                                    duration: Duration(milliseconds: 200),
////                                    opacity:
////                                        playProvider.getNumberStatus("green")
////                                            ? 1
////                                            : 0,
////                                    child: Container(
////                                      padding: EdgeInsets.all(25),
////                                      decoration: BoxDecoration(
////                                        shape: BoxShape.circle,
////                                        color: Colors.white,
////                                      ),
////                                      child: Text(
////                                        "+1",
////                                        style: TextStyle(fontSize: 80),
////                                      ),
////                                    ),
////                                  ),
////                                ),
////                              ],
////                            ),
////                          ),
////                        ),
////                        Container(
////                          child: Expanded(
////                            flex: 1,
////                            child: Container(
////                              height: 200,
////                            ),
////                          ),
////                        ),
////                        Expanded(
////                          flex: 18,
////                          child: Container(
////                            child: Stack(
////                              alignment: Alignment.center,
////                              children: <Widget>[
////                                GestureDetector(
////                                  onTap: () {
////                                    if (!playProvider
////                                        .getNumberStatus("yellow")) {
////                                      playProvider.setNumberStatus(
////                                          "yellow", true);
////                                      new Timer(new Duration(seconds: 1), () {
////                                        playProvider.setNumberStatus(
////                                            "yellow", false);
////                                      });
////                                    }
////                                  },
////                                  child: AnimatedContainer(
////                                      duration: Duration(milliseconds: 200),
////                                      decoration: BoxDecoration(
////                                          color: playProvider
////                                                  .getNumberStatus("yellow")
////                                              ? Color(0xffb47d00)
////                                              : Color(0xffffb100),
////                                          border: Border.all(
////                                              width: 5.0, color: Colors.white),
////                                          borderRadius: BorderRadius.all(
////                                              Radius.circular(30))),
////                                      height: 190,
////                                      width: 200,
////                                      alignment: Alignment.center,
////                                      child: Text(
////                                        'รู้',
////                                        style: TextStyle(
////                                            color: Colors.white, fontSize: 35),
////                                      )),
////                                ),
////                                IgnorePointer(
////                                  child: AnimatedOpacity(
////                                    duration: Duration(milliseconds: 200),
////                                    opacity:
////                                        playProvider.getNumberStatus("yellow")
////                                            ? 1
////                                            : 0,
////                                    child: Container(
////                                      padding: EdgeInsets.all(25),
////                                      decoration: BoxDecoration(
////                                        shape: BoxShape.circle,
////                                        color: Colors.white,
////                                      ),
////                                      child: Text(
////                                        "+1",
////                                        style: TextStyle(fontSize: 80),
////                                      ),
////                                    ),
////                                  ),
////                                ),
////                              ],
////                            ),
////                          ),
////                        ),
////                      ],
////                    ),
////                    Container(
////                      child: GridView.count(
////                        crossAxisCount: 2,
////                        children: List.generate(4, (index){
////                          return Container(
////                            child: Stack(
////                              alignment: Alignment.center,
////                              children: <Widget>[
////                                GestureDetector(
////                                  onTap: () {
////                                    if (!playProvider.getNumberStatus("blue")) {
////                                      playProvider.setNumberStatus("blue", true);
////                                      new Timer(new Duration(seconds: 1), () {
////                                        playProvider.setNumberStatus(
////                                            "blue", false);
////                                      });
////                                    }
////                                  },
////                                  child: AnimatedContainer(
////                                      duration: Duration(milliseconds: 200),
////                                      decoration: BoxDecoration(
////                                          color:
////                                          playProvider.getNumberStatus("blue")
////                                              ? Color(0xff003993)
////                                              : Color(0xff0062FF),
////                                          border: Border.all(
////                                              width: 5.0, color: Colors.white),
////                                          borderRadius: BorderRadius.all(
////                                              Radius.circular(30))),
////                                      height: maxHeight/3.75,
////                                      width: maxHeight/3.75,
////                                      alignment: Alignment.center,
////                                      child: Text(
////                                        'อยาก',
////                                        style: TextStyle(
////                                            color: Colors.white, fontSize: 35),
////                                      )),
////                                ),
////                                IgnorePointer(
////                                  child: AnimatedOpacity(
////                                    duration: Duration(milliseconds: 200),
////                                    opacity: playProvider.getNumberStatus("blue")
////                                        ? 1
////                                        : 0,
////                                    child: Container(
////                                      padding: EdgeInsets.all(25),
////                                      decoration: BoxDecoration(
////                                        shape: BoxShape.circle,
////                                        color: Colors.white,
////                                      ),
////                                      child: Text(
////                                        "+1",
////                                        style: TextStyle(fontSize: 80),
////                                      ),
////                                    ),
////                                  ),
////                                ),
////                              ],
////                            ),
////                          );
////                        }),
////                      )
////                    ),
////                    !playProvider.isPlay()
////                        ? GestureDetector(
////                            onTap: () {
////                              playProvider.play();
////                            },
////                            child: Container(
////                                margin: EdgeInsets.only(top: 40),
////                                decoration: BoxDecoration(
////                                    color: Colors.white,
////                                    borderRadius:
////                                        BorderRadius.all(Radius.circular(30))),
////                                height: 70,
////                                width: 250,
////                                alignment: Alignment.center,
////                                child: Text(
////                                  'เริ่มเล่น',
////                                  style: TextStyle(
////                                      color: Color(0xff00807A), fontSize: 30),
////                                )),
////                          )
////                        : Container(
////                            child: CountdownFormatted(
////                              duration: playProvider.getCountdown(),
////                              onFinish: () {
////                                showDialog(
////                                    context: context,
////                                    builder: (context) {
////                                      return AlertDialog(
////                                        contentPadding: EdgeInsets.zero,
////                                        content: Container(
////                                          decoration: BoxDecoration(
////                                            color: Color(0xff00746F),
////                                            border: Border.all(
////                                                width: 8.0,
////                                                color: Color(0xff00746F)),
////                                          ),
////                                          alignment: Alignment.center,
////                                          height: 400,
////                                          width: 400,
////                                          child: Column(
////                                            children: <Widget>[
////                                              Container(
////                                                alignment: Alignment.center,
////                                                color: Color(0xff00746F),
////                                                height: 60,
////                                                child: Text(
////                                                  'แต้มที่ได้ในครั้งนี้',
////                                                  style: TextStyle(
////                                                      color: Colors.white,
////                                                      fontSize: 30),
////                                                ),
////                                              ),
////                                              Expanded(
////                                                child: Container(
////                                                  color: Colors.white,
////                                                  alignment: Alignment.center,
////                                                  child: Container(
////                                                      decoration: BoxDecoration(
////                                                          shape:
////                                                              BoxShape.circle,
////                                                          color: Color(
////                                                              0xffFF0000)),
////                                                      height: 150,
////                                                      alignment:
////                                                          Alignment.center,
////                                                      child: Text(
////                                                        '20',
////                                                        style: TextStyle(
////                                                            color: Colors.white,
////                                                            fontSize: 80),
////                                                      )),
////                                                ),
////                                              ),
////                                              GestureDetector(
////                                                onTap: () {
////                                                  Navigator.of(context).pop();
////                                                },
////                                                child: Container(
////                                                  alignment: Alignment.center,
////                                                  color: Color(0xff00746F),
////                                                  height: 60,
////                                                  child: Text(
////                                                    'ตกลง',
////                                                    style: TextStyle(
////                                                        color: Colors.white,
////                                                        fontSize: 30),
////                                                  ),
////                                                ),
////                                              ),
////                                            ],
////                                          ),
////                                        ),
////                                      );
////                                    });
////                              },
////                              builder: (BuildContext ctx, String remaining) {
////                                return Container(
////                                    margin: EdgeInsets.only(top: 40),
////                                    decoration: BoxDecoration(
////                                        color: Color(0xff00807A),
////                                        borderRadius: BorderRadius.all(
////                                            Radius.circular(30))),
////                                    height: 70,
////                                    width: 250,
////                                    alignment: Alignment.center,
////                                    child: Text(
////                                      '${remaining}',
////                                      style: TextStyle(
////                                          color: Colors.white, fontSize: 30),
////                                    ));
////                              },
////                            ),
////                          ),
////                    playProvider.isPlay()
////                        ? GestureDetector(
////                            onTap: () {
////                              playProvider.stop();
////                            },
////                            child: Container(
////                              margin: EdgeInsets.only(top: 20),
////                              height: 50,
////                              alignment: Alignment.center,
////                              child: Icon(Icons.replay,
////                                  color: Colors.white, size: 50),
////                            ),
////                          )
////                        : Container()
//                  ],
//                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
