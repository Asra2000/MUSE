import 'package:flutter/material.dart';
import '../services/constants.dart';
import '../services/helper_classes.dart';
import '../services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/networking.dart';
import './player_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserScreen extends StatelessWidget {
  var _currentUser = Database().getCurrentUser();



  Widget showResult(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(_currentUser.uid).collection('liked').snapshots(),
      builder: (context, snapshot){
        List<Container> songCard = [];
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.withOpacity(0.5),
            ),
          );
        }
        final songs = snapshot.data.docs;
        for (var song in songs){
          final songTitle = song.data()['song'];
          final url = song.data()['url'];
          final artistImg = song.data()['artist_img'];
          final artistName = song.data()['artist_name'];
          final card =  Container(
            color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 2,
              height: 90.0,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.pink.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: InkWell(
                  onLongPress: (){
                      Database().deleteSong(song.id);
                  },
                  splashColor: lightPinkColor.withOpacity(0.3),
                  onTap: ()async {
                    NetworkHelper net = NetworkHelper(
                        url:
                        url);
                    String track = await net.getTrack();
                    // getting the track
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            trackUrl: track,
                          )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(artistImg),
                          radius: 50.0,
                        ),
                        Column(
                          children: [
                            Text(songTitle, style: songTextStyle,),
                            Text(artistName, style: artistTextStyle,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          );
          songCard.add(card);
        }

        return ListView(
          children: songCard,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('User alert!!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You are logged out'),
                  Text('To continue you will have to sign in again.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Continue'),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
              ),
            ],
          );
        },
      );
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Tooltip(
        message: "Logout",
        child: Theme(
          data: Theme.of(context).copyWith(highlightColor: Colors.yellow),
          child: FloatingActionButton(
            splashColor: Colors.white,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async{
              try {
                await FirebaseAuth.instance.signOut();
                _showMyDialog();
                // signed out
              } catch (e){
                // an error
                print("Error occurred");
              }
            },
          ),
        ),
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
                    height: height * .6,
                    margin: EdgeInsets.only(top: height * 0.15),
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
                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: showResult(),
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

