import 'package:flutter/material.dart';
import 'package:the_company/common/widgets/layouts/grid_layout.dart';
import 'package:the_company/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/utils/constants/sizes.dart';

import '../../../../../common/styles/spacing_styles.dart';
import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../gen/assets.gen.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: SpacingStyles.paddingWithDefaultSpaces,
          child: Column(
            children: [
              /// -- Brands

              BrandShowcase(
                images: [
                  Assets.images.products.footwear.men.a1831.path,
                  Assets.images.products.footwear.men.a1806.path,
                  Assets.images.products.footwear.men.a57501.path
                ],
              ),
              BrandShowcase(
                images: [
                  Assets.images.products.footwear.men.a1831.path,
                  Assets.images.products.footwear.men.a1806.path,
                  Assets.images.products.footwear.men.a57501.path
                ],
              ),

              ///  -- Products

              SectionHeading(
                title: "You might like",
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),
              GridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => const ProductCardVertical()),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              )
            ],
          ),
        ),
      ],
    );
  }
}
