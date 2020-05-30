import 'package:deepmind/providers/StatProvider.dart';
import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

TextEditingController _username = new TextEditingController();
TextEditingController _password = new TextEditingController();

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double _safeTop = MediaQuery.of(context).padding.top;

    double _safeBottom = MediaQuery.of(context).padding.bottom;

    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final StatProvider statProvider = Provider.of<StatProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: userProvider.loginStatus() ? Center(child: Container(child: CircularProgressIndicator(backgroundColor: Colors.white,valueColor: AlwaysStoppedAnimation<Color>(Color(0xff11BCB5)),),alignment: Alignment.center,color: Color(0xff11BCB5)),) : Container(
        color: Color(0xff11BCB5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Color(0xff11BCB5),
                      child: Text(
                        'ลงชื่อเข้าใช้',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    Container(
                      height: 50,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xff11BCB5),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        height: 50,
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Image.asset('assets/username.png'),
                              height: 30,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 15),
                                height: 30,
                                child: TextField(decoration: InputDecoration( hintText: "ชื่อผู้ใช้", hintStyle: TextStyle(color: Color(0xffA1EFEB), fontSize: 16),
                                  border: InputBorder.none ,contentPadding: EdgeInsets.only(top: 10,bottom: 10)
                                  // Added this
                                ),
                                style: TextStyle(color: Colors.white, fontSize: 16),
                                  controller: _username,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xff11BCB5),
                            border: Border.all(color: Colors.white),
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        height: 50,
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Image.asset('assets/password.png'),
                              height: 30,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 15),
                                height: 30,
                                child: TextField(decoration: InputDecoration( hintText: "รหัสผ่าน", hintStyle: TextStyle(color: Color(0xffA1EFEB), fontSize: 16),
                                    border: InputBorder.none ,contentPadding: EdgeInsets.only(top: 10,bottom: 10)
                                ),
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                  controller: _password,
                                  obscureText: true,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        userProvider.login(_username.text, _password.text).then((value) {
                          statProvider.loadStat().then((value) {
                            _username.clear();
                            _password.clear();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(0)));
                          });
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff00807A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    ),
                    Container(
                      height: 120,
                    ),

                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff11BCB5),
                          border: Border.all(color: Colors.white),
                        ),
                        height: 60,
                        alignment: Alignment.center,
                        child: Text('หรือ', style: TextStyle(color: Colors.white, fontSize: 18),)
                    ),


                    Container(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          child: Text(
                            'ลงทะเบียน',
                            style: TextStyle(
                                color: Color(0xff00807A), fontSize: 25),
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
