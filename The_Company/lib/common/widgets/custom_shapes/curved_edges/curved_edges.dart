import 'package:flutter/cupertino.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurved = Offset(0, size.height - 20);
    final lastCurved = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurved.dx, firstCurved.dy, lastCurved.dx, lastCurved.dy);

    final secondFirstCurved = Offset(0, size.height - 20);
    final secondLastCurved = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurved.dx, secondFirstCurved.dy,
        secondLastCurved.dx, secondLastCurved.dy);

    final thirdFirstCurved = Offset(size.width, size.height - 20);
    final thirdLastCurved = Offset(size.width, size.height);

    path.quadraticBezierTo(thirdFirstCurved.dx, thirdFirstCurved.dy,
        thirdLastCurved.dx, thirdLastCurved.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
