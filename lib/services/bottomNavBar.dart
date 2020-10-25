import 'package:flutter/material.dart';
import '../services/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Color backColor;
  CustomBottomNavBar({this.backColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft:Radius.circular(20.0)),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
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
                    IconButton(icon: Icon(Icons.radio, color: Colors.white,), onPressed: (){ Navigator.pushNamed(context, '/radio');},),
                    IconButton(icon: Icon(Icons.account_circle, color: Colors.white,), onPressed: (){},),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}