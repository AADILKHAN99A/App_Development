import 'package:flutter/material.dart';
import 'package:portfolio/constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  final double? width;

  const ResponsiveLayout(this.mobileBody, this.desktopBody,
      {super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
    print(constraints.maxWidth);
      if (width == null) {
        if (constraints.maxWidth < mobileWidth) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      }

      if (constraints.maxWidth < width!) {
        return mobileBody;
      } else {
        return desktopBody;
      }
    });
  }
}
