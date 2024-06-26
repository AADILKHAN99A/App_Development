import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/features/shop/screens/product_reviews/widget/progress_indicator_and_rating.dart';
import 'package:the_company/features/shop/screens/product_reviews/widget/rating_progress_indicator.dart';
import 'package:the_company/features/shop/screens/product_reviews/widget/user_review-card.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/device/device_utility.dart';

import '../../../../common/widgets/products/ratings/rating_indicator.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Reviews & Ratings"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithDefaultSpaces,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(
                height: CSizes.spaceBtwItems,
              ),

              /// Overall Product Ratings
              const OverallProductRating(),

              const CustomRatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                "12,611",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: CSizes.spaceBtwSections,),


              /// User Reviews List
              const UserReviewCard()
            ],
          ),
        ),
      ),
    );
  }
}
