import 'package:deepmind/pages/other.dart';
import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class EditprofilePage extends StatefulWidget {
  EditprofilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditprofilePage createState() => _EditprofilePage();
}

class _EditprofilePage extends State<EditprofilePage> {
  @override
  Widget build(BuildContext context) {
    double _safeTop = MediaQuery.of(context).padding.top;

    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        color: Color(0xff11BCB5),
        child: Column(
          children: <Widget>[
            Container(
              height: _safeTop,
              color: Color(0xff11BCB5),
            ),
            Container(
              height: 8,
              alignment: Alignment.center,
              color: Color(0xff11BCB5),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  color: Color(0xff11BCB5),
                  child: Text(
                    'โปรไฟล์',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffD8D8D8),
                              border: Border.all(width: 6.0, color: Colors.white),
                            ),
                            height: 150,
                            alignment: Alignment.center,
                          ),

                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                              userProvider.Name(),
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtherPage()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff098681),
                            border: Border(
                                bottom: BorderSide(color: Colors.white),
                                top: BorderSide(color: Colors.white)),
                          ),
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'บันทึก',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        userProvider.logout().then((value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffA3A3A3),
                            border: Border(
                                bottom: BorderSide(color: Colors.white),
                                top: BorderSide(color: Colors.white)),
                          ),
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'ออกจากระบบ',
                            style: TextStyle(color: Colors.white, fontSize: 25),
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
