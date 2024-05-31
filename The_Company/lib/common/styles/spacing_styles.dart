import 'package:flutter/cupertino.dart';

import '../../utils/constants/sizes.dart';

class SpacingStyles {
  static const EdgeInsetsGeometry paddingWithDefaultSpaces = EdgeInsets.only(
      top: CSizes.defaultSpace,
      left: CSizes.defaultSpace,
      right: CSizes.defaultSpace,
      bottom: CSizes.defaultSpace);

  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: CSizes.appBarHeight,
      left: CSizes.defaultSpace,
      right: CSizes.defaultSpace,
      bottom: CSizes.defaultSpace);

  static const EdgeInsetsGeometry paddingWithBtwItemSpaces = EdgeInsets.only(
      top: CSizes.spaceBtwItems,
      left: CSizes.spaceBtwItems,
      right: CSizes.spaceBtwItems,
      bottom: CSizes.spaceBtwItems);
}
