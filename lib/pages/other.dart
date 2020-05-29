import 'package:deepmind/providers/StatProvider.dart';
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

class IUser {
  String name;
  String image;
}

class _OtherPage extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    double _safeTop = MediaQuery.of(context).padding.top;
    double _safeBottom = MediaQuery.of(context).padding.bottom;

    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final StatProvider statProvider = Provider.of<StatProvider>(context);
    statProvider.getStatData();
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
                        child: Image.asset(
                          'assets/username.png',
                          height: 90,
                        ),
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
                              userProvider.Name() == null
                                  ? ''
                                  : userProvider.Name(),
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
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: statProvider.getStatData().length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
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
                                              'วันที่ ${index + 1}',
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
                                            padding: EdgeInsets.only(left: 15),
                                            height: 45,
                                            child: Text(
                                              '${statProvider.dayKeyToDateStr(statProvider.getStatData()[index]['day_key'])}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: List.generate(
                                          statProvider
                                              .getStatData()[index]['items']
                                              .length, (jdex) {
                                        return Container(
                                          padding: EdgeInsets.only(
                                              left: 40,
                                              right: 40,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
                                                child: Text(
                                                  "ครั้งที่ ${jdex+1}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: jdex % 2 == 0
                                                        ? Colors.white
                                                        : Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      statProvider
                                                          .getStatData()[index]
                                                              ['items'][jdex]
                                                              ['score']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: jdex % 2 == 0
                                                              ? Colors.red
                                                              : Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: 100,
                                                child: Text(
                                                  "แต้ม",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )),
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
