import 'package:flutter/cupertino.dart';
import 'package:the_company/utils/constants/color.dart';

class ShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: CColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final horizontalProductShadow = BoxShadow(
      color: CColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
