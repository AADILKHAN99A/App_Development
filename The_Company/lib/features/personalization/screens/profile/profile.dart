import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:the_company/common/styles/spacing_styles.dart';
import 'package:the_company/common/widgets/appbar/appbar.dart';
import 'package:the_company/common/widgets/images/circular_image.dart';
import 'package:the_company/common/widgets/texts/section_heading.dart';
import 'package:the_company/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:the_company/utils/constants/color.dart';
import 'package:the_company/utils/constants/image_strings.dart';
import 'package:the_company/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: SpacingStyles.paddingWithDefaultSpaces,
            child: Column(
              children: [
                /// Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircularImage(
                        image: CImages.userImage,
                        width: 80,
                        height: 80,
                        backgroundColor: CColors.grey,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Change Profile Picture")),
                    ],
                  ),
                ),

                /// Details
                const SizedBox(
                  height: CSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                const SectionHeading(
                  title: "Profile Information",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),

                ProfileMenu(
                  onPressed: () {},
                  title: 'Name',
                  value: 'Aadil Khan',
                ),
                ProfileMenu(
                  onPressed: () {},
                  title: 'Username',
                  value: 'AADILKHAN99A',
                ),

                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),
                const Divider(),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),

                /// Heading Personal INfo
                const SectionHeading(
                  title: "Personal Information",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),

                ProfileMenu(
                  onPressed: () {},
                  title: "User ID",
                  value: "45689",
                  icon: Iconsax.copy,
                ),
                ProfileMenu(
                    onPressed: () {}, title: "E-mail", value: "ada@gmail.com"),
                ProfileMenu(
                    onPressed: () {},
                    title: "Phone Number",
                    value: "+918114462733"),
                ProfileMenu(onPressed: () {}, title: "Gender", value: "Male"),
                ProfileMenu(
                    onPressed: () {},
                    title: "Date of Birth",
                    value: "10 Nov, 2001"),
                const Divider(),
                const SizedBox(
                  height: CSizes.spaceBtwItems,
                ),

                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Close Account",
                        style: TextStyle(color: Colors.red),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
