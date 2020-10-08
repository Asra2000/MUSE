import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/constants.dart';
import 'player_screen.dart';
import '../services/networking.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPinkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200.0),
                      bottomLeft: Radius.circular(5.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WHAT EVER YOUR MOOD WE ARE HERE TO LIGHT IT UP",
                      style: TextStyle(color: blackPink, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      "HERE ARE SOME TOP HITS",
                      style: TextStyle(color: Colors.pink, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SongCards(id: "99476756",),
                        SongCards(id: "99502558",),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SongCards extends StatelessWidget {
  final String id;
  SongCards({this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150.0,
        height: 150.0,
        color: blackPink,
      ),
      onTap: () async {
        NetworkHelper net = NetworkHelper();
        var temp = await net.track(id);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    trackUrl: temp,
                    isRadio: true,
                  )),
        );
      },
    );
  }
}
