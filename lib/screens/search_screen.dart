import 'package:flutter/material.dart';
import 'package:musa/screens/player_screen.dart';
import 'package:music_player/music_player.dart';
import '../services/constants.dart';
import '../services/songs.dart';
import '../services/networking.dart';
import '../services/bottomNavBar.dart';
import 'package:flutter_radio/flutter_radio.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searched = "";
  String trackUrl = "";
  List result;
  TextEditingController _controller = TextEditingController();
  MusicPlayer musicPlayer;
  List<Song> songs = [];

  Widget showResult() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          if (result[index]['kind'] == 'song')
            songs.add(Song(
                songUrl:
                    "https://itunes.apple.com/lookup?id=${result[index]['trackId']}",
                songName: result[index]['trackName'],
                artist: result[index]['artistName']));
          return (result[index]['kind'] == 'song')
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    NetworkHelper net = NetworkHelper(
                        url:
                            "https://itunes.apple.com/lookup?id=${result[index]['trackId']}");
                    String track = await net.getTrack();
                    // getting the track
                    setState(() {
                      trackUrl = track;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                                trackUrl: trackUrl,
                              )),
                    );
                  },
                  child: Card(
                    elevation: 1,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: pale,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 48,
                        height: 100,
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              NetworkImage(result[index]['artworkUrl100']),
                        ),
                      ),
                      title: Text(result[index]['trackName']),
                      dense: false,
                      subtitle: Text(result[index]['artistName'],style: TextStyle(color: blackPink),),
                      trailing: IconButton(
                        icon: Icon(
                          songs[index].liked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            songs[index].liked = !songs[index].liked;
                          });
                        },
                      ),
                    ),
                  ),
                )
              : Text("");
        });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    audioStart();
  }
  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -70,
              left: -70,
              child: Container(
                width: 320.0,
                height: 320.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: deepBlue.withAlpha(150),
                ),
              ),
            ),
            Positioned(
              top: .4 * MediaQuery.of(context).size.height,
              left: .22 * MediaQuery.of(context).size.width,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightPinkColor,
                ),
              ),
            ),
            Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    prefixIcon: Icon(
                      Icons.search,
                      color: blackPink,
                    ),
                    hintText: 'Enter song/artist/albums',
                    hintStyle: TextStyle(
                      color: brickRed,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
                onChanged: (value) {
                  searched = value;
                },
              ),
              FlatButton(
                onPressed: () async {
//                  print(searched);
                  NetworkHelper net = NetworkHelper(
                      url:
                          "https://itunes.apple.com/search?term=$searched&limit=10");
                  var temp = await net.getData();
                  setState(() {
                    result = temp;
                  });
                  _controller.clear();
                },
                child: Text(
                  'Search',
                  style: topHeadingStyle,
                ),
              ),

              SizedBox(
                height: 150.0,
              ),
              Expanded(
                child: result != null ? showResult() : Container(),
              )
            ],
          ),
          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomBottomNavBar(backColor: lightPinkColor,),
      ),
    );
  }
}

//"http://206.190.135.28:8332/stream"
//http://janus.cdnstream.com:5598/stream2
//http://api.shoutcast.com/legacy/Top500?k=qKAe6Vw5lR8EZNbn
//http://api.shoutcast.com/legacy/Top500?k=qKAe6Vw5lR8EZNbn&search=hindi
//http://yp.shoutcast.com/sbin/tunein-station.m3u?id=1858790
//"http://api.shoutcast.com/station/nowplaying?ct=rihanna&f=json&k=qKAe6Vw5lR8EZNbn"
//NetworkHelper net = NetworkHelper(
//    url:
//    "http://api.shoutcast.com/station/nowplaying?ct=rihanna&f=json&k=qKAe6Vw5lR8EZNbn");
//var temp = await net.getTopRadio();
//temp = await net.track("99476756");