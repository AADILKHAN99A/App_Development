import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final VoidCallback? callback;

  const Button({super.key, required this.btnName, this.icon, this.callback});

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
                      btnName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : Text(
                  btnName,
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
