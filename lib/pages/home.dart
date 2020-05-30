import 'package:deepmind/pages/play.dart';
import 'package:deepmind/providers/PlayProvider.dart';
import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'play.dart';
import 'other.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  int pageIndex;
  HomePage(this.pageIndex);
  @override
  _HomePageState createState() => _HomePageState(this.pageIndex);
}

List<Widget> pages = [
  PlayPage(),
  OtherPage(),
];

class _HomePageState extends State<HomePage> {

  int pageIndex;
  _HomePageState(this.pageIndex);
  PageController _pageController;
  final _auth = FirebaseAuth.instance;
  bool isSignIn = false;

  Future checkSignIn()async{
    FirebaseUser user = await _auth.currentUser();
    if(user == null){
      setState(() {
        isSignIn = false;
      });
    }else{
      setState(() {
        isSignIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this.pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _safeTop = MediaQuery.of(context).padding.top;
    double _safeBottom = MediaQuery.of(context).padding.bottom;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final PlayProvider playProvider = Provider.of<PlayProvider>(context);

    return Scaffold(
      body: Container(
          color: Color(0xffFCFCFC),
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
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    PlayPage(),
                    OtherPage(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                color: Color(0xff11BCB5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                            setState(() {
                              this.pageIndex = 0;
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.easeInOut,
                                );
                              }
                            });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width:3.0 ,color: Colors.white),
                            color: this.pageIndex == 0
                                ? Color(0xff00746F)
                                : Color(0xff11BCB5),
                          ),
                          height: 55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 35,
                                  child: Image.asset('assets/think.png')),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          playProvider.stop();
                           setState(() {
                             this.pageIndex = 1;
                             if (_pageController.hasClients) {
                               _pageController.animateToPage(
                                 1,
                                 duration: const Duration(milliseconds: 100),
                                 curve: Curves.easeInOut,
                               );
                             }
                           });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width:3.0 ,color: Colors.white),
                            color: this.pageIndex == 1
                                ? Color(0xff00746F)
                                : Color(0xff11BCB5),
                          ),
                          height: 55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 45,
                                  child: Image.asset('assets/other.png')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: _safeBottom,
                color: Color(0xff11BCB5),
              ),
            ],
          )),
    );
  }
}
