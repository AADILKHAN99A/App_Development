import 'package:flutter/material.dart';
import 'package:the_taskmanager/utils/constants/colors.dart';
import 'package:the_taskmanager/utils/constants/sizes.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.isLoading,
      this.color = CColors.primary,
      this.labelColor = Colors.white});

  final IconData? icon;
  final String? label;
  final Function()? onTap;
  final bool? isLoading;
  final Color color, labelColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: CSizes.md, horizontal: CSizes.spaceBtwItems),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(CSizes.borderRadiusLg)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null
                  ? Container()
                  : Icon(
                      icon,
                      color: Colors.white,
                    ),
              label == null
                  ? Container()
                  : Text(
                      label!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .apply(color: labelColor),
                    )
            ],
          ),
        ));
  }
}
