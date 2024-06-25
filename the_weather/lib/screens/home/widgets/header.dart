import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.areaName});

  final String areaName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${CTexts.locationSymbolEmoji} $areaName",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: CSizes.spaceBtwItems,
        ),
        Text(
          CTexts.homeGreetingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
