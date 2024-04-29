import 'package:flutter/material.dart';

class ThemeColors {
  static int aboutPageColor = 0xff008494;

  static const int aboutTextColor = 0xff83f9a8;
//0xff4189f8
}

class BackgroundColors {
  static Color colorSetter(int index) {
    switch (index) {
      case 0:
        return Colors.black;
      case 1:
        return Color(ThemeColors.aboutPageColor);
      case 2:
        return Colors.black;
      case 4:
        return Colors.black;
    }
    return Colors.transparent;
  }
}

class BackgroundImage {
  static ImageProvider<Object> backgroundImageSetter(int index) {
    switch (index) {
      case 0:
        return const AssetImage("assets/bg1.jpeg");
      case 1:
        return const AssetImage("assets/bg3.jpg");
      case 2:
        return const AssetImage("assets/bg4.jpg");
      case 3:
        return const AssetImage("assets/bg5.jpeg");
      case 4:
        return const AssetImage("assets/bg6.png");
    }
    return const AssetImage("assets/bg6.png");
  }
}

class ButtonColor {
  static Color backgroundColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xff353476);

      case 1:
        return const Color(0xff427154);

      case 2:
        return const Color(0xff4a4b4e);

      case 3:
        return const Color(0xff4e73aa);
      case 4:
        return  Colors.white;
    }
    return Colors.white;
  }
}
