import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';

class DualTonedBlur extends StatelessWidget {
  const DualTonedBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(4, -0.2),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: CColors.primary),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-4, -0.2),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: CColors.primary),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0, -1.2),
          child: Container(
            height: 300,
            width: 300,
            decoration: const BoxDecoration(color: CColors.secondary),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        )
      ],
    );
  }
}
