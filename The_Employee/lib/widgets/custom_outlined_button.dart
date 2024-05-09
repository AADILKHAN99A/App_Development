import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_employee/widgets/base_button.dart';

class CustomOutlinedButton extends BaseButton {
  CustomOutlinedButton(
      {Key? key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label,
      VoidCallback? onPressed,
      ButtonStyle? buttonStyle,
      TextStyle? buttonTextStyle,
      bool? isDisabled,
      Alignment? alignment,
      double? height,
      double? width,
      EdgeInsets? margin,
      required String text})
      : super(
            text: text,
            onPressed: onPressed,
            buttonTextStyle: buttonTextStyle,
            isDisabled: isDisabled,
            buttonStyle: buttonStyle,
            height: height,
            alignment: alignment,
            width: width,
            margin: margin);

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget,
          )
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: height ?? 56,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: buttonTextStyle ??
                    const TextStyle(
                      color: Colors.black,
                    ),
              ),
              rightIcon ?? const SizedBox.shrink()
            ],
          ),
        ),
      );
}
