import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_image.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(
        image: CImages.userImage,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        "Aadil Khan",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: CColors.white),
      ),
      subtitle: Text(
        "abcd@gmail.com",
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: CColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: CColors.white)),
    );
  }
}
