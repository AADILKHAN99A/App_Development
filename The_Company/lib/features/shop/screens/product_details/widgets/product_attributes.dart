import 'package:flutter/material.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:the_company/common/widgets/texts/product_title_text.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/coice_chip.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        RoundedContainer(
          padding: const EdgeInsets.all(CSizes.md),
          backgroundColor: dark ? CColors.darkerGrey : CColors.grey,
          child: Column(
            children: [
              /// Title, Price and Stock Stavs
              Row(
                children: [
                  const SectionHeading(
                    title: "Variation",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: CSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ProductTitleText(
                            title: "Price : ",
                            smallSize: true,
                          ),

                          /// Actual Price
                          Text(
                            "₹2500",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: CSizes.spaceBtwItems,
                          ),

                          /// Sale Price
                          Text(
                            "₹2500",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const ProductTitleText(
                            title: "Stock : ",
                            smallSize: true,
                          ),
                          Text(
                            "In Stock",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const ProductTitleText(
                title:
                    "This is the Description of the Product and it can go up to max 4 lines",
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(
          height: CSizes.spaceBtwItems,
        ),

        /// -- Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: "Colors",
              showActionButton: false,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                CChoiceChip(
                  text: 'Green',
                  selected: true,
                  onSelected: (value) {},
                ),
                CChoiceChip(
                  text: 'Red',
                  selected: false,
                  onSelected: (value) {},
                ),
                CChoiceChip(
                  text: 'Yellow',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: "Size",
              showActionButton: false,
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                CChoiceChip(
                  text: 'EU 34',
                  selected: true,
                  onSelected: (value) {},
                ),
                CChoiceChip(
                  text: 'EU 36',
                  selected: false,
                  onSelected: (value) {},
                ),
                CChoiceChip(
                  text: 'EU 38',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
