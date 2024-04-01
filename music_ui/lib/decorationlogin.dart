import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputDecoration({
    required String hintext,
    required String labeltext,
    required Icon icono,
  }) {
    return InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2)),
      hintText: hintext,
      labelText: labeltext,
      prefixIcon: icono,
    );
  }
}
