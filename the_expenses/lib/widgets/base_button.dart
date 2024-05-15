import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? buttonTextStyle;
  final ButtonStyle? buttonStyle;
  final bool? isDisabled;

  final double? height;
  final double? width;
  final EdgeInsets? margin;

  const BaseButton(
      {
      required this.text,
      this.onPressed,
      this.buttonTextStyle,
      this.isDisabled,
      this.height,
      this.width,
      this.margin,
      this.alignment, this.buttonStyle});

  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
