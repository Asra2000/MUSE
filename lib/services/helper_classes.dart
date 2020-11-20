import 'package:flutter/material.dart';
import 'package:musa/screens/playlist_screen.dart';
import '../services/constants.dart';
import '../services/networking.dart';


///////////////////////////////////////////////////////////////////
class CustomContainers extends StatelessWidget {
  final String imageUrl;
  final Color blendColor;

  const CustomContainers({@required this.imageUrl, @required this.blendColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, blendColor],
        ),
        image: DecorationImage(
          alignment: Alignment.bottomRight,
          image: AssetImage(imageUrl),
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.dstATop),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////
class CardRows extends StatelessWidget {
  final String image1Url, image2Url, text1, text2; List<String> searched;

  CardRows(
      {this.image1Url, this.image2Url, this.text1, this.text2, this.searched});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 250.0,
            child: SongCard(
              imageUrl: image1Url,
              captions: text1,
              blurColor: grey,
//              searched: text1.toLowerCase(),
              isArtist: true,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 15.0),
            height: 250.0,
            child: SongCard(
              blurColor: grey,
              imageUrl: image2Url,
              captions: text2,
//              searched: text2.toLowerCase(),
              isArtist: true,
            ),
          ),
        )
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////
class SongCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final Color blurColor;
  final String captions;
  final List<String> searched;
  final bool isArtist;

  SongCard(
      {this.imageUrl,
      this.text = "",
      this.blurColor = rosePink,
      this.captions = "",
      this.searched,
      this.isArtist = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 180.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: blurColor,
            offset: Offset(5.0, 5.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Material(
        child: InkWell(
          onTap: () async {
            print(isArtist);var temp;
            if(isArtist){
              NetworkHelper net =  NetworkHelper(
                  url:
                  "https://itunes.apple.com/search?term=$captions&limit=15") ;
              temp =  await net.getData();
            }
            else{
              NetworkHelper net = NetworkHelper(url: "https://itunes.apple.com/search?term=${searched[0]}&limit=10");
              temp = await net.getData();
            }
//        print(temp);
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PlaylistScreen(songs: temp)));
          },
          hoverColor: lightPinkColor.withOpacity(0.3),
          highlightColor: lightPinkColor.withOpacity(0.3),
          splashColor: lightPinkColor.withOpacity(0.6),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    letterSpacing: 8,
                    backgroundColor: blackPink.withOpacity(.2),
                  ),
                ),
                Text(
                  captions,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                    fontSize: 15.0,
                    letterSpacing: 5,
                    backgroundColor: blackPink.withOpacity(.2),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////
class BtnStyle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: <Color>[
            rosePink,
            darkPink,
          ],
        ),
      ),
      padding: EdgeInsets.all(15.0),
      child: Text('Submit', style: headingStyleW),
    );
  }
}
//////////////////////////////////////////////////////////////////////////////////
Widget CircleContainer({Color color = Colors.white, double size = 160}) {
  return Container(
    alignment: Alignment.center,
    child: InkWell(
      child: new Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(20.0),
        //I used some padding without fixed width and height
        decoration: new BoxDecoration(
          shape: BoxShape
              .circle, // You can use like this way or like the below line
          //                borderRadius: new BorderRadius.circular(30.0),
          color: color,
        ),
        child: new Text("",
            style: new TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
        alignment: Alignment.center,
      ),
    ),
  );
}
