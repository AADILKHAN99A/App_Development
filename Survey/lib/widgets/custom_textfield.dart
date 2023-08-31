import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged onChange;
  final bool? enable;
  final String? hintText;
  final String? errorText;
  final String? copyData;

  const CustomTextField({
    super.key,
    required this.onChange,
    this.enable,
    this.hintText,
    this.errorText,
    this.copyData,
  });

  @override
  State<StatefulWidget> createState() => CustomText();
}

class CustomText extends State<CustomTextField>
    with AutomaticKeepAliveClientMixin {
  TextEditingController controller = TextEditingController();

  // validate()
  // {
  //   if(controller.text=="")
  //     {
  //       return "Field Empty";
  //     }
  //   else {
  //     return null;
  //   }
  // }
  //

  datacopy() {
    if (widget.enable == false) {
      setState(() {
        controller.text = widget.copyData!;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TextField(
      controller: controller,
      enabled: widget.copyData == null ? widget.enable : datacopy(),
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

  @override
  bool get wantKeepAlive => true;
}
