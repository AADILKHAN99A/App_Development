import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged onChange;
  final bool? enable;
  final String? hintText;
  final String? errorText;
  const CustomTextField(
      {super.key, required this.onChange, this.enable, this.hintText, this.errorText});

  @override
  State<StatefulWidget> createState() => CustomText();
}

class CustomText extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();

  // void onChange(String value) {
  //   controller.text = value;
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: controller,
      enabled: widget.enable,
      onChanged: (value) => widget.onChange(value),
      decoration: InputDecoration(
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.6000000238418579),
            fontWeight: FontWeight.w400),
        contentPadding: const EdgeInsets.only(left: 22, bottom: 3),
        border: InputBorder.none,
      ),
    );
  }
}
