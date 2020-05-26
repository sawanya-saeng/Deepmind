import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class PlayPage extends StatefulWidget {
  PlayPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlayPage createState() => _PlayPage();
}

class _PlayPage extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    double _safeTop = MediaQuery.of(context).padding.top;
    double _safeBottom = MediaQuery.of(context).padding.bottom;

    final UserProvider userProvider = Provider.of<UserProvider>(context);
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
                  padding: EdgeInsets.only(top:8,bottom: 8),
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
                padding: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 15),
//                color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            flex: 18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff0062FF),
                                    border: Border.all(
                                        width: 5.0, color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                height: 190,
                                width: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  'อยาก',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              height: 200,
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffE01D1D),
                                    border: Border.all(
                                        width: 5.0, color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                height: 190,
                                width: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  'โทสะ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            flex: 18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff51D300),
                                    border: Border.all(
                                        width: 5.0, color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                height: 190,
                                width: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  'หลง',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 1,
                            child: Container(
                              height: 200,
                            ),
                          ),
                        ),
                        Container(
                          child: Expanded(
                            flex: 18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffFFB100),
                                    border: Border.all(
                                        width: 5.0, color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                height: 190,
                                width: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  'รู้',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top:40),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        height: 70,
                        width: 250,
                        alignment: Alignment.center,
                        child: Text(
                          'เริ่มเล่น',
                          style:
                              TextStyle(color: Color(0xff00807A), fontSize: 30),
                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(top:20),
                        height: 50,
                        alignment: Alignment.center,
                        child: Icon(Icons.replay, color: Colors.white, size: 50),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
