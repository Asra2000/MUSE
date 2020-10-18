import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var roundnessFactor = 80.0;
    var path = Path();

    path.lineTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

///////////////////////////////////////////////////////////////////////////////
class BackgroundClipper1 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var roundnessFactor = 80.0;
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(0, size.height - roundnessFactor);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

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
