import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(top: CSizes.appBarHeight),
      child: SizedBox(
          width: HelperFunctions.screenWidth(),
          height: 200,
          child: Image(
            image: AssetImage(
              dark ? CImages.blackLogoWithText : CImages.whiteLogoWithText,
            ),
          )),
    );
  }
}