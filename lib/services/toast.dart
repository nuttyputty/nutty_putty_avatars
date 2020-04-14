import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';

showToast(message, [success]) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: success == null ? Colors.red : hexToColor('#1f5c9a'),
      textColor: Colors.white,
      fontSize: 16.0);
}
