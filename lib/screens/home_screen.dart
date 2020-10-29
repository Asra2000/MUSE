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
      body: SingleChildScrollView(
        child: Column(
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
            Text(
              "Listen to music that you prefer",
              style: headingStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
              height: 250.0,
              padding: EdgeInsets.all(5.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SongCard(
                    imageUrl: homeCardImageHindi,
                    text: "Hindi",
                    searched: "hindi",
                  ),
                  SongCard(
                    imageUrl: homeCardImageEnglish,
                    text: "English",
                    searched: "english",
                  ),
                  SongCard(
                    imageUrl: homeCardImageJazz,
                    text: "Jazz",
                    searched: "jazz",
                  ),
                  SongCard(
                    imageUrl: homeCardImagePop,
                    text: "Pop",
                    searched: "pop",
                  ),
                ],
              ),
            ),
            Text(
              "Pick from top ARTISTS",
              style: headingStyle,
            ),
            SizedBox(height: 10.0,),
            Column(
              children: [
                CardRows(
                  image1Url: ArtistImageTaylor,
                  image2Url: ArtistImageCharlie,
                  text1: "TAYLOR SWIFT",
                  text2: "CHARLIE PUTH",
                ),
                CardRows(
                  image1Url: ArtistImageBrunoMars,
                  image2Url: ArtistImageKaty,
                  text1: "BRUNO MARS",
                  text2: "KATY PERRY",
                ),
                CardRows(
                  image1Url: ArtistImageBeyonce,
                  image2Url: ArtistImageLittleMix,
                  text1: "BEYONCE",
                  text2: "LITTLE MIX",
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

