import 'package:flutter/material.dart';
import '../services/constants.dart';
import '../services/helper_classes.dart';
import '../services/database.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        backgroundColor: Colors.black,
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -(height * .4),
              left: -(height / 2 - width / 2),
              child: Container(
                width: height,
                height: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height,
                    child: Stack(
                      children: <Widget>[
                        FractionalTranslation(
                          translation: Offset(0, -0.12),
                          child: CircleContainer(
                              color: Colors.pink.withAlpha(100),
                              size: width / 1.4),
                        ),
                        FractionalTranslation(
                          translation: Offset(0.0, -0.07),
                          child: CircleContainer(
                              color: Colors.pink.withAlpha(170),
                              size: width / 2),
                        ),
                        FractionalTranslation(
                          translation: Offset(0, -0.03),
                          child: CircleContainer(
                              color: Colors.pink, size: width / 3),
                        ),
                        Center(
                            child: Text(
                          "Your likes",
                          style: topHeadingStyle,
                        )),
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

