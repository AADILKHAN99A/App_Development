import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:the_company/common/widgets/products/ratings/rating_indicator.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(CImages.userProfileImage1),
                ),
                const SizedBox(
                  width: CSizes.spaceBtwItems,
                ),
                Text(
                  "John Doe",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          width: CSizes.spaceBtwItems,
        ),

        /// Reviews

        Row(
          children: [
            CustomRatingBarIndicator(rating: 4),
            const SizedBox(
              width: CSizes.spaceBtwItems,
            ),
            Text(
              "01 Nov, 2023",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          height: CSizes.spaceBtwItems,
        ),
        ReadMoreText(
          "aldfjlaf adfjasdfalkd dlfjkad faljdf  asdlfja sdfl asdfjadlf alsdjf sdfjldsfj asdfjlasd fsdlfja sdf",
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: " show less",
          trimCollapsedText: " show more",
          moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CColors.darkGrey),
          lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CColors.darkGrey),
        ),
        const SizedBox(
          height: CSizes.spaceBtwItems,
        ),

        /// Company Review
        RoundedContainer(
          backgroundColor: dark ? CColors.darkerGrey : CColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(CSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("T's Store",
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      "02 Nov, 2023",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                ReadMoreText(
                  "aldfjlaf adfjasdfalkd dlfjkad faljdf  asdlfja sdfl asdfjadlf alsdjf sdfjldsfj asdfjlasd fsdlfja sdf",
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: " show less",
                  trimCollapsedText: " show more",
                  moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CColors.darkGrey),
                  lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CColors.darkGrey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: CSizes.spaceBtwSections,
        )
      ],
    );
  }
}
