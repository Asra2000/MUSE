import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/bottomNavBar.dart';
import '../services/constants.dart';
import 'package:music_player/music_player.dart';
import 'package:flutter_radio/flutter_radio.dart';



class PlayerScreen extends StatefulWidget {
  final String trackUrl;
  final bool isRadio;

  PlayerScreen({this.trackUrl, this.isRadio = false});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  MusicPlayer musicPlayer =  MusicPlayer();
  bool isRadioPlaying = false;

  @override
  void initState() {
    super.initState();
    audioStart();
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

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
                image: !this.widget.isRadio
                    ? AssetImage('assets/back.jpg')
                    : AssetImage('assets/back1.jpg'),
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
                          if(widget.trackUrl != null) {
                            if (!widget.isRadio) {
                              musicPlayer.play(MusicItem(
                                trackName: 'Sample',
                                albumName: 'Sample Album',
                                artistName: 'Sample Artist',
                                url: widget.trackUrl,
                                duration: Duration(seconds: 30),
                              ));
                            }else{
                              print("here " +  widget.trackUrl);
                                FlutterRadio.play(url: widget.trackUrl);
                            }
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.isRadio ? FlutterRadio.stop() :
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
