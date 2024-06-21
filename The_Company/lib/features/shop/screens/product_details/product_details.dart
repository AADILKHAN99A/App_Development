import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:the_company/common/widgets/icons/circular_icon.dart';
import 'package:the_company/common/widgets/images/rounded_image.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/prduct_meta_data.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:the_company/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../gen/assets.gen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
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

                  ProductMetaData()

                  /// -- Attributes
                  /// -- Checkout Button
                  /// -- Description
                  /// -- Reviews
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
