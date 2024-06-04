import 'package:flutter/material.dart';

import '../../../../utils/constants/color.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.padding = 0,
    this.child,
    this.backgroundColor = CColors.white,
    this.margin,
    this.radius = 400,
  });

  final double? width;
  final double? height;

  final double padding;
  final Widget? child;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundColor),
      child: child,
    );
  }
}
