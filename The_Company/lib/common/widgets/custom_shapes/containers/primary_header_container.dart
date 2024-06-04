import 'package:flutter/material.dart';

import '../../../../utils/constants/color.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: CColors.primary,
        padding: const EdgeInsets.all(0),

        /// -- If [size.inFinite: is not true. in Stack] error occurred --> Read README.md file at
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              /// -- Background Custom shapes
              Positioned(
                  top: -150,
                  right: -250,
                  child: CircularContainer(
                    backgroundColor: CColors.textWhite.withOpacity(0.1),
                  )),
              Positioned(
                  top: 100,
                  right: -300,
                  child: CircularContainer(
                    backgroundColor: CColors.textWhite.withOpacity(0.1),
                  )),
              child
            ],
          ),
        ),
      ),
    );
  }
}
