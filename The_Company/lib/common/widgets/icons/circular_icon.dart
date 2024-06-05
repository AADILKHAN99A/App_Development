import 'package:iconsax/iconsax.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/color.dart';

class CircularIcon extends StatelessWidget {
  /// A custom Circular Icon widget with a background color.
  ///
  /// Properties are:
  /// Container [width], [height] & [backgroundColor]
  ///
  /// Icon's [size], [color] & [onPressed]
  const CircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = CSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor ??
              (dark
                  ? CColors.black.withOpacity(0.9)
                  : CColors.white.withOpacity(0.9))),
      child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}
