import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:validators/validators.dart';

class MyColors {
  static const MaterialColor darkBlue = MaterialColor(
    0xFF20314E,
    <int, Color>{
      50: Color(0xFF1e4b9a),
      100: Color(0xFF1e4b9a),
      200: Color(0xFF1e4b9a),
      300: Color(0xFF1e4b9a),
      400: Color(0xFF1e4b9a),
      500: Color(0xFF1e4b9a),
      600: Color(0xFF1e4b9a),
      700: Color(0xFF1e4b9a),
      800: Color(0xFF1e4b9a),
      900: Color(0xFF1e4b9a),
    },
  );
  static Color backgroundColor() => HexColor("#20314E");
  static Color yellowColor() => HexColor("#F4DE4C");
  static Color textBoxColor() => HexColor("#949695");
}
