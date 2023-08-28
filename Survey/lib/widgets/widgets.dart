import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final String btnname;
  final Icon? icon;
  final VoidCallback? callback;

  const button({super.key, required this.btnname, this.icon, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 16),
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    Text(
                      btnname,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : Text(
                  btnname,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
        ),
        onPressed: () {
          callback!();
        },
      ),
    );
  }
}

// class textfield extends FormField<String>{
//   final Key key;
//   final String hinttext;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldValidator<String>? validate;
//   final bool? enable;
//   final TextEditingController controller;
//   final bool obscureText;
//
//
//
//
// }
//
// class textfieldstatus extends State<textfield>
// {
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
