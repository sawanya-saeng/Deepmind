import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _safeTop = MediaQuery.of(context).padding.top;

    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: userProvider.addLoading() ? CircularProgressIndicator(): Container(
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
                    'ลงทะเบียน',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15,),
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

                    Container(
                      padding: EdgeInsets.only(top:30,left: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ขื่อผู้ใช้',
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 15,left: 30,right: 30),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color(0xff11BCB5),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.white),
                                  )
                                 ),
                              height: 45,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: username,
                                decoration: InputDecoration.collapsed(hintText: ""),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    Container(
                      height: 30,
                    ),

                    Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'รหัสผ่าน',
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 15,left: 30,right: 30),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Color(0xff11BCB5),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.white),
                                  )
                              ),
                              height: 45,
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration.collapsed(hintText: ""),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      height:250,
                    ),

                    GestureDetector(
                      onTap: () {
                        userProvider.setAddLoading(true);
                        userProvider.register(username.text, password.text).then((value) {
                          userProvider.setAddLoading(false);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            'ยืนยัน',
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
