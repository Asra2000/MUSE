import 'package:flutter/material.dart';
import '../services/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft:Radius.circular(20.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [peach.withAlpha(255), pale],
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(icon: Icon(Icons.home, color: Colors.white,), onPressed: (){Navigator.popAndPushNamed(context, '/home');},),
                  IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){
                    Navigator.popAndPushNamed(context, '/search');
                  },),
                  IconButton(icon: Icon(Icons.playlist_play, color: Colors.white,), onPressed: (){},),
                  IconButton(icon: Icon(Icons.account_circle, color: Colors.white,), onPressed: (){},),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}