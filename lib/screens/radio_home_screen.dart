import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/constants.dart';
import 'player_screen.dart';
import '../services/networking.dart';
import '../services/bottomNavBar.dart';
import 'dart:io';

class RadioScreen extends StatelessWidget {
  final NetworkHelper net = new NetworkHelper(
      url:
          'http://api.shoutcast.com/station/nowplaying?ct=rihanna&f=json&k=qKAe6Vw5lR8EZNbn');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    try {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -(height * .25),
                left: -(height / 2 - width / 2),
                child: Container(
                  width: height,
                  height: height,
                  decoration: BoxDecoration(
//                    color: lightPurple.withAlpha(100),
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xfff9c5d1), Color(0xff9795ef)]),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Carry the radio wherever you go",
                        style: topHeadingStyle,
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Text(
                        "HERE ARE SOME TOP HITS",
                        style: headingStyle,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SongCards(
                            id: "99476756",
                            logo:
                                'http://i.radionomy.com/document/radios/c/c680/c6800ef5-f347-4f6e-9f55-22dd8ae43957.jpg',
                          ),
                          SongCards(
                            id: "99502558",
                            logo:
                                'http://i.radionomy.com/document/radios/e/eaff/eaffb379-6436-4d27-876b-2a4dfcf54b26.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SongCards(
                              id: "99367199",
                              logo:
                                  'http://i.radionomy.com/document/radios/4/4e70/4e701cc0-e2df-401c-9af0-18453804caed.jpg'),
                          SongCards(
                            id: "1623071",
                            logo:
                                'https://www.listenonlineradio.com/wp-content/uploads/Oye-India-Radio.jpg',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SongCards(
                            id: "99384331",
                            logo:
                                'http://i.radionomy.com/document/radios/3/3717/37178dd7-0d0a-4c63-b04a-d4b4937a5486.png',
                          ),
                          SongCards(
                            id: "99498352",
                            logo:
                                'http://i.radionomy.com/document/radios/b/bdd4/bdd4b069-8a86-4d1f-b918-4aadcce751a1.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SongCards(
                            id: "99498352",
                            logo:
                                'http://i.radionomy.com/document/radios/7/7b3f/7b3f524b-86e8-43aa-894c-6d73d1510580.jpg',
                          ),
                          SongCards(
                            id: "99304647",
                            logo:
                                'http://i.radionomy.com/document/radios/7/7d44/7d44daa4-709e-4223-ba77-b04f1adc4a70.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      //bollywood
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SongCards(
                            id: "1798887",
                            logo:
                                'http://i.radionomy.com/document/radios/9/9070/907013f3-3406-43c1-842c-ba8750ccfcaf.jpg',
                          ),
                          SongCards(
                            id: "99498900",
                            logo:
                                'http://i.radionomy.com/document/radios/f/fed6/fed6376f-2553-4f42-8bdb-63e827bca452.jpg',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: CustomBottomNavBar(),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Get top radio",
          elevation: 15.0,
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: () {
            net.getTopRadio();
          },
        ),
      );
    } on SocketException catch (_) {
      return Scaffold(
        body: Container(
          child: Text("Sorry, no connection. Try again later"),
        ),
        bottomNavigationBar: BottomAppBar(
          child: CustomBottomNavBar(),
        ),
      );
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
class SongCards extends StatelessWidget {
  final String id;
  final String logo;

  SongCards({this.id, this.logo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
            color: lightPinkColor.withAlpha(100),
            shape: BoxShape.circle,
            image: logo != null
                ? DecorationImage(image: NetworkImage(logo), fit: BoxFit.cover)
                : null,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 15.0,
                  spreadRadius: 10.0,
                  color: Colors.white.withOpacity(0.6)),
            ]),
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
