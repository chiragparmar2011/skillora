import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color? getColorFromHex() {
    var hexColor = replaceAll('#', '').replaceAll('0x', '').replaceAll('0X', '').trim();
    if (hexColor.isNotEmpty) {
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      int? val = int.tryParse(hexColor, radix: 16);
      if (val != null) {
        return Color(val);
      }
    }
    return null;
  }

}
