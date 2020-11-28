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
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [peach.withAlpha(255), pale],
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(4),
                      child: IconButton(
                        splashColor: lightPinkColor.withOpacity(0.7),
                        splashRadius: 500,
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/home');
                        },
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(4),
                      child: IconButton(
                        splashColor: lightPinkColor.withOpacity(0.7),
                        splashRadius: 500,
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/search');
                        },
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(4),
                      child: IconButton(
                        splashColor: lightPinkColor.withOpacity(0.7),
                        splashRadius: 500,
                        icon: Icon(
                          Icons.radio,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/radio');
                        },
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(4),
                      child: IconButton(
                        splashColor: lightPinkColor.withOpacity(0.7),
                        splashRadius: 500,
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/user');
                        },
                      ),
                    ),
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
