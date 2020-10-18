import 'package:flutter/material.dart';
import '../services/constants.dart';
import '../services/bottomNavBar.dart';
import '../services/helper_classes.dart';
import '../services/networking.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var topSpace = MediaQuery.of(context).size.height * 0.17;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BackgroundClipper(),
                child: CustomContainers(
                  imageUrl: 'assets/headphone.jpg',
                  blendColor: deepBlue,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: topSpace),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      'DISCOVER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        letterSpacing: 16.0,
                      ),
                    ),
                    Text(
                      "your feed",
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 16.0,
                          letterSpacing: 10.0),
                    )
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/radio');
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

