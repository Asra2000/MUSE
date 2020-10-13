import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/constants.dart';
import 'player_screen.dart';
import '../services/networking.dart';
import '../services/bottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  final NetworkHelper net = new NetworkHelper(url :'http://api.shoutcast.com/station/nowplaying?ct=rihanna&f=json&k=qKAe6Vw5lR8EZNbn');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.black,
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
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      "HERE ARE SOME TOP HITS",
                      style: TextStyle(color: lightPinkColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SongCards(id: "99476756", logo: 'http://i.radionomy.com/document/radios/c/c680/c6800ef5-f347-4f6e-9f55-22dd8ae43957.jpg',),
                        SongCards(id: "99502558", logo: 'http://i.radionomy.com/document/radios/e/eaff/eaffb379-6436-4d27-876b-2a4dfcf54b26.png',),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SongCards(id: "99367199", logo: 'http://i.radionomy.com/document/radios/4/4e70/4e701cc0-e2df-401c-9af0-18453804caed.jpg'),
                        SongCards(id: "1623071",logo: 'https://www.listenonlineradio.com/wp-content/uploads/Oye-India-Radio.jpg',),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SongCards(id: "99384331", logo: 'http://i.radionomy.com/document/radios/3/3717/37178dd7-0d0a-4c63-b04a-d4b4937a5486.png',),
                        SongCards(id: "99498352", logo: 'http://i.radionomy.com/document/radios/b/bdd4/bdd4b069-8a86-4d1f-b918-4aadcce751a1.png',),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SongCards(id: "99498352", logo: 'http://i.radionomy.com/document/radios/7/7b3f/7b3f524b-86e8-43aa-894c-6d73d1510580.jpg',),
                        SongCards(id: "99304647",logo: 'http://i.radionomy.com/document/radios/7/7d44/7d44daa4-709e-4223-ba77-b04f1adc4a70.png',),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    //bollywood
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SongCards(id: "1798887", logo: 'http://i.radionomy.com/document/radios/9/9070/907013f3-3406-43c1-842c-ba8750ccfcaf.jpg',),
                        SongCards(id: "99498900",logo: 'http://i.radionomy.com/document/radios/f/fed6/fed6376f-2553-4f42-8bdb-63e827bca452.jpg',),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomBottomNavBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          net.getTopRadio();
        },
      ),
    );
  }
}

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
        child: logo !=null ? Image.network(logo, width: 150.0, height: 150.0,) : null,
        decoration: BoxDecoration(
            color: lightPinkColor.withAlpha(100),
      ),
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
