import 'package:flutter/material.dart';


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
  final bool expands;

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
    this.prefixText,
    this.prefixIcon,
    this.expands = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      expands: expands,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        labelText: label,
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
