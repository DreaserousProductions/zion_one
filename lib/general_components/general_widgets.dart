import 'package:flutter/material.dart';

import 'package:zion_one/general_components/palette.dart';

Widget generalOutlineButton(
  void Function()? onPressedFunc,
  Color bgColor,
  Color txtColor,
  double letSpace,
  double foSize,
  String buttonText,
) {
  return OutlinedButton(
    onPressed: onPressedFunc,
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      side: const BorderSide(
        width: 1,
        color: paletteDark,
      ),
      backgroundColor: bgColor,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: "Zilla Slab SemiBold",
          fontSize: foSize,
          letterSpacing: letSpace,
          color: txtColor,
        ),
      ),
    ),
  );
}
