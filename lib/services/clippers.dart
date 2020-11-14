import 'package:flutter/material.dart';

class BackgroundClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = new Offset(size.width / 4, size.height);
    var firstEndPoint = new Offset(size.width / 2, size.height - 75);
    var secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height/3);
    var secondEndPoint = new Offset(size.width, size.height/2);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

//////////////////////////////////////////////////////////////////////

class BackgroundClipper extends CustomClipper<Path> {
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

