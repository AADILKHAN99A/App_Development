import 'package:flutter/material.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/common/widgets/appbar/tabbar.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:the_company/common/widgets/layouts/grid_layout.dart';
import 'package:the_company/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/features/shop/screens/store/widgets/category_tab.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/sizes.dart';
import 'package:the_company/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/brands/brand_card/brand_card.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          title: const Text("Store"),
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
                              itemBuilder: (_, index) => const BrandCard(
                                    showBorder: false,
                                  ))
                        ],
                      ),
                    ),

                    /// -- Tabs
                    bottom: const CustomTabBar(tabs: [
                      Tab(child: Text("Sports")),
                      Tab(child: Text("Furniture")),
                      Tab(child: Text("Electronics")),
                      Tab(child: Text("Clothes")),
                      Tab(child: Text("Cosmetics")),
                    ]))
              ];
            },

            // -- Body
            body: const TabBarView(children: [
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
            ])),
      ),
    );
  }
}
