import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import './screens/player_screen.dart';
import './screens/search_screen.dart';
import './screens/radio_home_screen.dart';
import './screens/home_screen.dart';
import './screens/signUp.dart';
import './screens/login.dart';
import './screens/playlist_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
            next: (context) => RegistrationScreen(),
            startAnimation: 'enter',
            backgroundColor: Color(0xffffffff),
            until: () => Future.delayed(Duration(seconds: 6)),
          ),
          Image.asset("assets/back.png",height: 400.0,)
        ],
      ),
      routes: {
        '/home' : (context) => HomeScreen(),
        '/radio': (context) => RadioScreen(),
        '/search' :(context) => SearchScreen(),
        '/player' : (context) => PlayerScreen(),
        '/login'  :(context) => LoginScreen(),
        '/sign' : (context) => RegistrationScreen(),
        '/playlist': (context) => PlaylistScreen(songs: null)
      },
    );
  }
}
