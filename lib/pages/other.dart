import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'editprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class OtherPage extends StatefulWidget {
  OtherPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OtherPage createState() => _OtherPage();
}


class IUser{
  String name;
  String image;
}


class _OtherPage extends State<OtherPage> {
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
            Container(
                height: 150,
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffD8D8D8),
                          border: Border.all(width: 6.0, color: Colors.white),
                        ),
                        height: 110,
                        alignment: Alignment.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditprofilePage()));
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'แก้ไขข้อมูลส่วนตัว >',
                                style: TextStyle(
                                    color: Color(0xffA1EFEB), fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.white),
                            top: BorderSide(color: Colors.white)),
                      ),
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'แต้มที่ได้ทั้งหมด',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: ListView(
                            padding: const EdgeInsets.all(0),
                            children: <Widget>[
                              Container(
                                height: 160,
                                padding: EdgeInsets.only(bottom: 8),
                                color: Color(0xff11BCB5),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 45,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white),
                                                    top: BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              alignment: Alignment.center,
                                              height: 45,
                                              child: Text(
                                                'วันที่ 1',
                                                style: TextStyle(
                                                    color: Color(0xff098681),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xff098681),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white),
                                                    top: BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              height: 45,
                                              child: Text(
                                                '25 พฤษภาคม 2563',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 45,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'ครั้งที่ 1',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        padding: EdgeInsets.only(
                                                            left: 15),
                                                        height: 45,
                                                        child: Container(
                                                            decoration:
                                                            BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                            height: 60,
                                                            alignment: Alignment.center,
                                                            child: Text('12', style: TextStyle(color:Color(0xffFF0000), fontSize: 20),
                                                            )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'แต้ม',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'ครั้งที่ 2',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 15),
                                                        height: 45,
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(shape: BoxShape.circle, color:Color(0xffFF0000)),
                                                            height: 60,
                                                            alignment: Alignment.center,
                                                            child: Text('20', style: TextStyle(color: Colors.white, fontSize: 20),
                                                            )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'แต้ม',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
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
                                  ],
                                ),
                              ),
                              Container(
                                height: 160,
                                padding: EdgeInsets.only(bottom: 8),
                                color: Color(0xff11BCB5),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 45,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white),
                                                    top: BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              alignment: Alignment.center,
                                              height: 45,
                                              child: Text(
                                                'วันที่ 1',
                                                style: TextStyle(
                                                    color: Color(0xff098681),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xff098681),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white),
                                                    top: BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              alignment: Alignment.centerLeft,
                                              padding:
                                              EdgeInsets.only(left: 15),
                                              height: 45,
                                              child: Text(
                                                '26 พฤษภาคม 2563',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 45,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'ครั้งที่ 1',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        padding: EdgeInsets.only(
                                                            left: 15),
                                                        height: 45,
                                                        child: Container(
                                                            decoration:
                                                            BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                                            height: 60,
                                                            alignment: Alignment.center,
                                                            child: Text('12', style: TextStyle(color:Color(0xffFF0000), fontSize: 20),
                                                            )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'แต้ม',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'ครั้งที่ 2',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        padding:
                                                        EdgeInsets.only(
                                                            left: 15),
                                                        height: 45,
                                                        child: Container(
                                                            decoration:
                                                            BoxDecoration(shape: BoxShape.circle, color:Color(0xffFF0000)),
                                                            height: 60,
                                                            alignment: Alignment.center,
                                                            child: Text('20', style: TextStyle(color: Colors.white, fontSize: 20),
                                                            )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        height: 45,
                                                        child: Text(
                                                          'แต้ม',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white,
                                                              fontSize: 20),
                                                        ),
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
                                  ],
                                ),
                              ),



                            ],
                          )),
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
