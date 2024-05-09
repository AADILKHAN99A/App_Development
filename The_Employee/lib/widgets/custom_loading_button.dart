import 'package:flutter/material.dart';
import 'package:the_employee/utils/color_constants.dart';

class CustomLoadingButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final VoidCallback? callback;

  final bool? loading;

  const CustomLoadingButton(
      {super.key,
      required this.btnName,
      this.icon,
      this.callback,
      this.loading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(darkBlue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28))),
        child: loading == true
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 11.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Padding(
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
