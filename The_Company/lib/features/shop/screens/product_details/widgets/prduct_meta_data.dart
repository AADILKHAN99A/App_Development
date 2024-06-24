import 'package:flutter/material.dart';
import 'package:the_company/common/widgets/images/circular_image.dart';
import 'package:the_company/common/widgets/texts/brand_titile_text_with_verified_icon.dart';
import 'package:the_company/common/widgets/texts/product_price_text.dart';
import 'package:the_company/common/widgets/texts/product_title_text.dart';
import 'package:the_company/utils/constants/enum.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            RoundedContainer(
              radius: CSizes.sm,
              backgroundColor: CColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: CSizes.sm, vertical: CSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: CColors.black),
              ),
            ),

            const SizedBox(
              width: CSizes.spaceBtwItems,
            ),

            /// Price
            Text(
              "₹1000",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: CSizes.spaceBtwItems,
            ),
            const ProductPriceText(
              price: "750",
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: CSizes.spaceBtwItems / 1.5,
        ),

        /// Title
        const ProductTitleText(title: "White Nike Sport Shoes"),
        const SizedBox(height: CSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const ProductTitleText(title: "Status"),
            const SizedBox(
              width: CSizes.spaceBtwItems,
            ),
            Text(
              "In Stock",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: CSizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            CircularImage(
              image: Assets.icons.categories.shoes.path,
              width: 32,
              height: 32,
              overlayColor: dark ? CColors.white : CColors.black,
            ),
            const BrandTitleWithVerifiedIcon(
              title: "Nike",
              brandTextSizes: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
