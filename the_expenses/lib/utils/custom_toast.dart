import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'color_constants.dart';


commonToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(darkBlue),
      textColor: Colors.white,
      fontSize: 16.0
  );
}