import 'package:flutter/material.dart';

import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';
class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Flexible(
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: true,
              onChanged: (value) {
                // controller.updateCheckedTAC(!controller.checkedTAC.value);
              }),
        ),
        const SizedBox(
          width: CSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: '${CTexts.iAgreeTo} ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
              text: '${CTexts.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? CColors.white : CColors.primary,
                  decoration: TextDecoration.underline)),
          TextSpan(
              text: '${CTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: CTexts.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? CColors.white : CColors.primary,
                  decoration: TextDecoration.underline)),
        ]))
      ],
    );
  }
}