import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../utils/constants/color.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return CurvedEdgeWidget(
      child: Container(
        color: dark ? CColors.darkerGrey : CColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(CSizes.productImageRadius * 2),
                  child: Center(
                    child: Image(
                        image: AssetImage(
                            Assets.images.products.footwear.men.a1636.path)),
                  ),
                )),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: CSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (_, index) {
                    return RoundedImage(
                        fit: BoxFit.cover,
                        backgroundColor: dark ? CColors.dark : CColors.white,
                        border: Border.all(color: CColors.primary),
                        width: 80,
                        imageUrl:
                            Assets.images.products.footwear.men.a1806.path);
                  },
                  separatorBuilder: (_, index) {
                    return const SizedBox(width: CSizes.spaceBtwItems);
                  },
                ),
              ),
            ),

            /// Appbar Icons
            const CustomAppBar(
              showBackArrow: true,
              actions: [
                CircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
