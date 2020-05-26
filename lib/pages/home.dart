import 'package:deepmind/pages/play.dart';
import 'package:deepmind/providers/PlayProvider.dart';
import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'play.dart';
import 'other.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

int _currentIndex = 0;

class _HomePageState extends State<HomePage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentIndex = 0;
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
                              _currentIndex = 0;
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
                            color: _currentIndex == 0
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
                             _currentIndex = 1;
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
                            color: _currentIndex == 1
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
