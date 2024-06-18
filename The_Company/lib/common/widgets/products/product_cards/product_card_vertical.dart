import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/styles/shadow.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:the_company/common/widgets/images/rounded_image.dart';
import 'package:the_company/common/widgets/texts/product_title_text.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../gen/assets.gen.dart';
import '../../icons/circular_icon.dart';
import '../../texts/brand_titile_text_with_verified_icon.dart';
import '../../texts/product_price-text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    /// Container with side padding, color, edges, radius and shadow
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(CSizes.productImageRadius),
            color: dark ? CColors.darkerGrey : CColors.white),
        child: Column(
          children: [
            /// Thumbnail, Wishlist Button, discount Tag
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(CSizes.sm),
              backgroundColor: dark ? CColors.dark : CColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  RoundedImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: Assets.images.products.footwear.men.a1636.path,
                    applyImageRadius: true,
                  ),

                  /// -- Sale Tag
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

                  /// -- Favourite Icon Button
                  const Positioned(
                    top: -3,
                    right: -5,
                    child: CircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems / 2,
            ),

            /// -- Details
            const Padding(
              padding: EdgeInsets.only(left: CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(
                    title: "White Nike Shoes",
                    smallSize: true,
                  ),
                  SizedBox(
                    height: CSizes.spaceBtwItems/2,
                  ),
                  BrandTitleWithVerifiedIcon(title: 'Nike',),
                ],
              ),
            ),

            /// Use Spacer() if needed
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                const Padding(
                  padding: EdgeInsets.only(left: CSizes.sm),
                  child: ProductPriceText(
                    price: '4000',
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: CColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(CSizes.cardRadiusMd),
                        bottomRight: Radius.circular(CSizes.productImageRadius),
                      )),
                  child: const SizedBox(
                    width: CSizes.iconLg * 1.2,
                    height: CSizes.iconLg * 1.2,
                    child: Icon(
                      Iconsax.add,
                      color: CColors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


