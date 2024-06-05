import 'package:flutter/material.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:the_company/common/widgets/layouts/grid_layout.dart';
import 'package:the_company/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/enum.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/texts/brand_titile_text_with_verified_icon.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Store"),
        actions: [
          CartCounterIcon(onPressed: () {}, iconColor: CColors.primary)
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrollable) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: HelperFunctions.isDarkMode(context)
                    ? CColors.black
                    : CColors.white,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: SpacingStyles.paddingWithDefaultSpaces,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ///- Search bar
                      const SizedBox(
                        height: CSizes.spaceBtwItems,
                      ),
                      const SearchContainer(
                        text: "Search in Store",
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: CSizes.spaceBtwSections,
                      ),

                      /// -- Featured Brands
                      SectionHeading(
                          title: "Featured Brands", onPressed: () {}),
                      const SizedBox(
                        height: CSizes.spaceBtwItems / 1.5,
                      ),

                      GridLayout(
                          mainAxisExtend: 80,
                          itemCount: 4,
                          itemBuilder: (_, index) => GestureDetector(
                                onTap: () {},
                                child: RoundedContainer(
                                  padding: const EdgeInsets.all(CSizes.sm),
                                  showBorder: true,
                                  backgroundColor: Colors.transparent,
                                  borderColor: CColors.grey,
                                  child: Row(
                                    children: [
                                      /// -- Icon
                                      Flexible(
                                        child: CircularImage(
                                          image: CImages.clothesIcon,
                                          isNetworkImage: false,
                                          backgroundColor: Colors.transparent,
                                          overlayColor:
                                              HelperFunctions.isDarkMode(
                                                      context)
                                                  ? CColors.white
                                                  : CColors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: CSizes.spaceBtwSections / 2,
                                      ),

                                      /// -- Text
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const BrandTitleWithVerifiedIcon(
                                              title: 'Nike',
                                              brandTextSizes: TextSizes.large,
                                            ),
                                            Text(
                                              "256 Products",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container()),
    );
  }
}
