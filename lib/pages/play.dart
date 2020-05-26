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
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 15),
//                color: Colors.red,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            flex: 18,
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                  onLongPress: (){

                            },
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
                              ],
                            ),
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
                    !playProvider.isPlay()
                        ? GestureDetector(
                            onTap: () {
                              playProvider.play();
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 40),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                height: 70,
                                width: 250,
                                alignment: Alignment.center,
                                child: Text(
                                  'เริ่มเล่น',
                                  style: TextStyle(
                                      color: Color(0xff00807A), fontSize: 30),
                                )),
                          )
                        : Container(
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
                                                width: 8.0,
                                                color: Color(0xff00746F)),
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
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color(0xffFF0000)),
                                                      height: 150,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        '20',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 80),
                                                      )),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
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
                                    margin: EdgeInsets.only(top: 40),
                                    decoration: BoxDecoration(
                                        color: Color(0xff00807A),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    height: 70,
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
                    playProvider.isPlay()
                        ? GestureDetector(
                            onTap: () {
                              playProvider.stop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 50,
                              alignment: Alignment.center,
                              child: Icon(Icons.replay,
                                  color: Colors.white, size: 50),
                            ),
                          )
                        : Container()
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
