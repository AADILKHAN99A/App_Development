import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:the_company/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/features/personalization/screens/profile/profile.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ---Header
            PrimaryHeaderContainer(
                child: Column(
              children: [
                /// App Bar
                CustomAppBar(
                    title: Text(
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: CColors.white),
                )),
                const SizedBox(
                  height: CSizes.defaultSpace,
                ),

                /// User Profile Card
                UserProfileTile(
                  onPressed: () => Get.to(const ProfileScreen()),
                ),
                const SizedBox(
                  height: CSizes.spaceBtwSections,
                )
              ],
            )),

            /// ---Body

            Padding(
                padding: SpacingStyles.paddingWithDefaultSpaces,
                child: Column(
                  children: [
                    /// -- Account Settings
                    const SectionHeading(
                      title: "Account Settings",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: CSizes.spaceBtwItems,
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: "My Addresses",
                      subTitle: "Set shopping delivery address",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: "My Cart",
                      subTitle: "Add, remove products and move to checkout",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subTitle: "In- Progress and Completed Orders",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.bank,
                      title: "Bank Account",
                      subTitle: "Withdraw balance to registered bank account",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: "My Coupons",
                      subTitle: "List of all the discounted coupons",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subTitle: "Set any kind of notification message",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: "Account Privacy",
                      subTitle: "Manage data usage and connected accounts",
                      onTap: () {},
                    ),

                    /// --- App Settings
                    const SizedBox(
                      height: CSizes.spaceBtwSections,
                    ),
                    const SectionHeading(
                      title: "App Settings",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: CSizes.spaceBtwItems,
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subTitle: "Upload Data to your Cloud Firebase",
                      onTap: () {},
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.location,
                      title: "GeoLocation",
                      subTitle: "Set recommendation based on location",
                      onTap: () {},
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: "Safe Mode",
                      subTitle: "Search result is safe for all ages",
                      onTap: () {},
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.image,
                      title: "HD Image Quality",
                      subTitle: "Set image quality to be seen",
                      onTap: () {},
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),

                    /// -- Logout Button
                    const SizedBox(
                      height: CSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text("Logout")),
                    ),
                    const SizedBox(
                      height: CSizes.spaceBtwSections * 2.5,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
