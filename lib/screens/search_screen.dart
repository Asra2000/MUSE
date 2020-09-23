import 'package:flutter/material.dart';
import '../services/networking.dart';
import 'package:music_player/music_player.dart';
import '../services/bottomNavBar.dart';

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

  Widget showResult() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          return (result[index]['kind'] == 'song')? GestureDetector(
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
            },
            child: ListTile(
              leading: Container(
                width: 48,
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(result[index]['artworkUrl100']),
                ),
              ),
              title: Text(result[index]['trackName']),
              dense: false,
              subtitle: Text(result[index]['artistName']),
            ),
          ) : Text("");
        });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter song/artist/albums',
                  hintStyle: TextStyle(
                    color: Colors.yellow[100],
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
                NetworkHelper net = NetworkHelper(
                    url:
                    "https://itunes.apple.com/search?term=$searched&limit=10");
                var temp = await net.getData();
                setState(() {
                  result = temp;
                  print(result);
                });
                _controller.clear();
              },
              child: Text(
                'Search',
              ),
            ),
            FlatButton(
              onPressed: () async {
                NetworkHelper net = NetworkHelper(
                    url:
                    "http://api.shoutcast.com/station/nowplaying?ct=rihanna&f=json&k=qKAe6Vw5lR8EZNbn");
                var temp = await net.getTopRadio();
//                print(temp);
                net.track();
              },
              child: Text(
                'Radio',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          musicPlayer.play(MusicItem(
            trackName: 'Sample',
            albumName: 'Sample Album',
            artistName: 'Sample Artist',
            url: trackUrl,
            duration: Duration(seconds: 30),
          ));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomBottomNavBar(),
      ),
    );
  }
}



//"http://206.190.135.28:8332/stream"
//http://janus.cdnstream.com:5598/stream2
//http://api.shoutcast.com/legacy/Top500?k=qKAe6Vw5lR8EZNbn
//http://api.shoutcast.com/legacy/Top500?k=qKAe6Vw5lR8EZNbn&search=hindi
//http://yp.shoutcast.com/sbin/tunein-station.m3u?id=1858790