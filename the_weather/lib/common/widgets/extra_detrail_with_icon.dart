import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class ExtraDetailsWithIcon extends StatelessWidget {
  const ExtraDetailsWithIcon({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          scale: 8,
        ),
        const SizedBox(
          width: CSizes.xs,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              width: CSizes.xs,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
