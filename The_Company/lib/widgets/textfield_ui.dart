import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/constants/color.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final Widget? suffixIcon;

  final TextEditingController controller;

  final bool? obscureText;

  final String? Function(String?)? validator;

  final FocusNode? focusNode;

  final TextInputType keyboardType;
  final void Function()? onEditingComplete;
  final String? prefixText;

  final Widget? prefixIcon;

  const CommonTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    required this.controller,
    this.obscureText,
    this.validator,
    this.focusNode,
    required this.keyboardType,
    this.onEditingComplete,
    this.prefixText,  this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: const TextStyle(color: Colors.grey),
        labelText: label,
        labelStyle: const TextStyle(
            fontSize: 15, color: CColors.accent, fontWeight: FontWeight.w600),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.blue, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.blue, width: 2)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.grey, width: 2)),
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }
}
