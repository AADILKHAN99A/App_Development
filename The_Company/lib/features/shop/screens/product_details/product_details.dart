import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/prduct_meta_data.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:the_company/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:the_company/utils/constants/sizes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Product Image Slider

            ProductImageSlider(),

            /// Product Details

            Padding(
              padding: EdgeInsets.only(
                  right: CSizes.defaultSpace,
                  left: CSizes.defaultSpace,
                  bottom: CSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Rating & Share Button

                  RatingAndShare(),

                  /// -- Price, Title, Stack & Brand

                  ProductMetaData(),

                  /// -- Attributes

                  ProductAttributes(),
                  const SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  /// -- Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Checkout"))),
                  const SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),

                  /// -- Description
                  const SectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: CSizes.spaceBtwSections,
                  ),
                  const ReadMoreText(
                    "This is a product aldkjf alsdjkfalsdkjf alskdjf alsdkjf asldkjf ldkjf alsdkjf alskdjf adlskfj asdkljf asldkjflkj adflkj kjf adkfj alkdjf d",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// -- Reviews
                  const Divider(),
                  const SizedBox(
                    height: CSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionHeading(
                        title: "Reviews(99)",
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () => Get.to(() => const ProductReviewsScreen()),
                          icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  const SizedBox(height: CSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
