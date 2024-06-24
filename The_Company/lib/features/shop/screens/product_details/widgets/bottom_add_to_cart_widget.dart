import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/widgets/icons/circular_icon.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CSizes.defaultSpace, vertical: CSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? CColors.darkerGrey : CColors.light,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(CSizes.cardRadiusLg),
              topRight: Radius.circular(CSizes.cardRadiusLg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                icon: Iconsax.minus,
                backgroundColor: CColors.darkerGrey,
                width: 40,
                height: 40,
                color: CColors.white,
              ),
              const SizedBox(
                width: CSizes.spaceBtwItems,
              ),
              Text(
                "2",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: CSizes.spaceBtwItems,
              ),
              CircularIcon(
                icon: Iconsax.add,
                backgroundColor: CColors.darkerGrey,
                width: 40,
                height: 40,
                color: CColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Add To Cart"),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(CSizes.md),
                backgroundColor: CColors.black,
                side: const BorderSide(color: CColors.black)),
          )
        ],
      ),
    );
  }
}
