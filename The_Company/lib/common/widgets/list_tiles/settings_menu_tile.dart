import 'package:flutter/material.dart';
import 'package:the_company/utils/constants/color.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.trailing, required this.onTap});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: CColors.primary,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
