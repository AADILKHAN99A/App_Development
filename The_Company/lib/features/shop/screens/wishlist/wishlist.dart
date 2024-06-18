import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/common/widgets/icons/circular_icon.dart';
import 'package:the_company/common/widgets/layouts/grid_layout.dart';
import 'package:the_company/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:the_company/features/shop/screens/home/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "WishList",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SpacingStyles.paddingWithDefaultSpaces,
            child: Column(
              children: [
                GridLayout(
                    itemCount: 2,
                    itemBuilder: (_, index) => const ProductCardVertical())
              ],
            )),
      ),
    );
  }
}
