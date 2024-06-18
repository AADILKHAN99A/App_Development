import 'package:flutter/material.dart';
import 'package:the_company/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:the_company/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:the_company/features/shop/screens/home/widgets/home_categories.dart';
import 'package:the_company/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header

            const PrimaryHeaderContainer(
              child: Column(
                children: [
                  ///-- Appbar
                  HomeAppBar(),
                  SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  /// --- Searchbar
                  SearchContainer(
                    text: 'Search in Store',
                  ),
                  SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  /// --- Categories
                  Padding(
                    padding: EdgeInsets.only(left: CSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// --- Heading

                        SectionHeading(
                          title: "Popular Categories",
                          textColor: CColors.white,
                          showActionButton: false,
                        ),
                        SizedBox(height: CSizes.spaceBtwItems),

                        /// --- Categories

                        HomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: CSizes.spaceBtwSections,
                  )
                ],
              ),
            ),

            /// Body

            Padding(
              padding: const EdgeInsets.all(CSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Promo Slider
                  PromoSlider(
                    banners: [
                      CImages.promoBanner1,
                      CImages.promoBanner2,
                      CImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  /// -- Heading
                  SectionHeading(
                    title: "Popular Products",
                    onPressed: () {},
                  ),
                  const SizedBox(height: CSizes.spaceBtwItems),

                  /// -- Popular Products
                  GridLayout(
                    itemCount: 2,
                    itemBuilder: (_, index) => const ProductCardVertical(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
