import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/device/device_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
        this.title,
        this.actions,
        this.leadingIcon,
        this.leadingOnPressed,
        this.showBackArrow = false});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;

  final List<Widget>? actions;

  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(
              onPressed: Get.back,
              icon: const Icon(
                  Icons.arrow_back_ios_new_outlined
              ))
              : leadingIcon != null
              ? IconButton(
              onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null,
          title: title,
          actions: actions,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
