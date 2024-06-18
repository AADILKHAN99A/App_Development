import 'package:flutter/material.dart';
import 'package:the_company/common/widgets/images/rounded_image.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';
import '../../../utils/constants/color.dart';
import '../../../utils/constants/sizes.dart';
import '../../styles/spacing_styles.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card/brand_card.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return RoundedContainer(
      showBorder: true,
      borderColor: CColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: SpacingStyles.paddingWithBtwItemSpaces,
      padding: const EdgeInsets.all(CSizes.md),
      child: Column(
        children: [
          /// Brands with products count
          const BrandCard(
            showBorder: false,
          ),
          const SizedBox(
            height: CSizes.spaceBtwItems,
          ),

          /// Brand Top 3 Images
          Row(
              children: images
                  .map((image) =>
                      brandTopProductImageWidget(context, image, dark))
                  .toList())
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(
      BuildContext context, String image, bool dark) {
    return Expanded(
      child: RoundedContainer(
        height: 100,
        backgroundColor: dark ? CColors.darkGrey : CColors.light,
        margin: const EdgeInsets.only(right: CSizes.sm),
        child: RoundedImage(
          fit: BoxFit.cover,
          imageUrl: image,
        ),
      ),
    );
  }
}
