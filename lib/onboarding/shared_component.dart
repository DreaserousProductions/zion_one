import "package:flutter/material.dart";

// Local Imports
import "package:zion_one/general_components/palette.dart";
import "package:zion_one/general_components/variable_sizes.dart";

Widget buildInputField(
  TextEditingController controller,
  Color textColor,
  Color borderColor,
  double textSize,
  String labelText,
  String? errorText,
  bool obscure,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.0 * screenFactor),
    child: TextFormField(
      controller: controller,
      cursorColor: textColor,
      obscureText: obscure,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: paletteDark,
          fontSize: 12 * screenFactor,
          fontFamily: 'Playwrite',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        errorText: errorText,
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Playwrite',
          fontWeight: FontWeight.bold,
          fontSize: textSize * screenFactor,
          color: textColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 0, 0),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: paletteDark,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: paletteDark,
            width: 1,
          ),
        ),
      ),
      style: TextStyle(
        color: textColor,
        fontSize: textSize * screenFactor,
      ),
    ),
  );
}
