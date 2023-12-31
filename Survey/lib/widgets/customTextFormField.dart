import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final ValueChanged onChange;
  final bool? enable;
  final String? hintText;
  final String? errorText;
  final String? copyData;
  final Key valueKey;
  final Function? validator;
  final String? keyboardType;
  final int? maxLength;
  const CustomTextFormField({
    super.key,
    required this.onChange,
    this.enable,
    this.hintText,
    this.errorText,
    this.copyData,
    required this.valueKey,
    this.validator,
    this.keyboardType,
    this.maxLength,
  });

  @override
  State<StatefulWidget> createState() => CustomText();
}

class CustomText extends State<CustomTextFormField>
    with AutomaticKeepAliveClientMixin {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller;
  }

  keyboard() {
    switch (widget.keyboardType) {
      case "name":
        {
          return TextInputType.name;
        }
      case "address":
        {
          return TextInputType.streetAddress;
        }
      case "email":
        {
          return TextInputType.emailAddress;
        }
      case "phone":
        {
          return TextInputType.phone;
        }
      default:
        {
          return TextInputType.text;
        }
    }
  }

  datacopy() {
    if (widget.enable == false) {
      controller.text = widget.copyData!;
      // setState(() {});
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TextFormField(
      maxLength: widget.maxLength,
      keyboardType: keyboard(),
      controller: controller,
      validator: (input) => widget.validator!(input),
      key: widget.valueKey,
      enabled: widget.copyData == null ? widget.enable : datacopy(),
      onChanged: (value) => widget.onChange(value),
      decoration: InputDecoration(
        counter: SizedBox.shrink(),
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

  @override
  bool get wantKeepAlive => true;
}
