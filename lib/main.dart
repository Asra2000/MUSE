import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import './screens/player_screen.dart';
import './screens/search_screen.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent
      ),
      title: 'Flare Welcome',
      debugShowCheckedModeBanner: true,
      home: Stack(
        children: [
          SplashScreen.navigate(
            name: 'assets/splash.flr',
            next: (context) => HomeScreen(),
            startAnimation: 'enter',
            backgroundColor: Color(0xffffffff),
            until: () => Future.delayed(Duration(seconds: 6)),
          ),
          Image.asset("assets/back.png",height: 400.0,)
        ],
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/search' :(context) => SearchScreen(),
        '/player' : (context) => PlayerScreen(),
      },
    );
  }
}
