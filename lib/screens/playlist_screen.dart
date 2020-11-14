import 'package:flutter/material.dart';
import 'package:musa/services/database.dart';
import '../services/constants.dart';
import '../services/songs.dart';
import '../services/networking.dart';
import './player_screen.dart';
import '../services/bottomNavBar.dart';
import '../services/database.dart';
import '../services/clippers.dart';

class PlaylistScreen extends StatefulWidget {
  final List songs;

  PlaylistScreen({Key key, @required this.songs}) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List result;
  List<Song> songs = [];
  String trackUrl = "";

  Widget showResult() {
    result = widget.songs;
//    print(result.length);
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          if (result[index]['kind'] == 'song') {
            songs.add(Song(
              artistImg: result[index]['artworkUrl100'],
                songUrl:
                "https://itunes.apple.com/lookup?id=${result[index]['trackId']}",
                songName: result[index]['trackName'],
                artist: result[index]['artistName']));
          }
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
//                      print(track);
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
                    elevation: 2,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: blackPink,
                        width: 1.5,
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
                      subtitle: Text(result[index]['artistName'], style: TextStyle(color: peach),),
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
                          Database().addToLikedSongs(songs[index]);
                        },
                      ),
                    ),
                  ),
                )
              : Text("");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:  Column(
          children: [
            Expanded(
              child: ClipPath(
                clipper: BackgroundClipper2(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [peach.withOpacity(0.4), rosePink]
                    )
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.5,
                  child: showResult(),
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomBottomNavBar(backColor: lightPinkColor,),
      ),
    );
  }
}
