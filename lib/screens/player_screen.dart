import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/bottomNavBar.dart';
import '../services/constants.dart';
import 'package:music_player/music_player.dart';


class PlayerScreen extends StatelessWidget {
  final String imageUrl;
  final String trackUrl;
  final MusicPlayer musicPlayer =  MusicPlayer();

  PlayerScreen({this.imageUrl, this.trackUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                image: this.imageUrl != null
                    ? NetworkImage(this.imageUrl)
                    : AssetImage('assets/seaside.jpg'),
                colorFilter: ColorFilter.mode(pale, BlendMode.colorBurn),
                fit: BoxFit.cover,
              ),
            )),
            Positioned(
              left: -MediaQuery.of(context).size.width / 2,
              child: Image.asset('assets/disk.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: (){},
                          child: Icon(
                            Icons.skip_next,
                            size: 60.0,
                            color: Colors.white,
                          )),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: brickRed, blurRadius: 5)]
                          ),
                          child: Icon(
                            Icons.play_circle_outline,
                            size: 100.0,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          if(trackUrl != null) {
                            musicPlayer.play(MusicItem(
                              trackName: 'Sample',
                              albumName: 'Sample Album',
                              artistName: 'Sample Artist',
                              url: trackUrl,
                              duration: Duration(seconds: 30),
                            ));
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: (){
                          musicPlayer.pause();
                        },
                          child: Icon(
                        Icons.pause,
                        size: 60.0,
                        color: Colors.white,
                      ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  )
                ],
              ),
            ),
            CustomBottomNavBar(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin : EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2.0)]
                ),
                child: IconButton(icon: Icon(Icons.arrow_back_ios,color:  lightPinkColor,), onPressed: (){
                  Navigator.pop(context);
                },),
              ),
            )
          ],
        ),
      ),
    );
  }
}
