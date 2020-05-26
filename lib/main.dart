import 'package:deepmind/pages/login.dart';
import 'package:deepmind/providers/PlayProvider.dart';
import 'package:deepmind/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: UserProvider()) ,
          ChangeNotifierProvider<PlayProvider>.value(value: PlayProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DeepMind',
          theme: ThemeData(
            primaryColor: Color(0xff11BCB5),
              fontFamily: 'appFont'
          ),
          home: LoginPage(title: 'DeepMind'),
        ));
  }
}
