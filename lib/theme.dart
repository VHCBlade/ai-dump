import 'package:flutter/material.dart';
import 'package:vhcblade_theme/vhcblade_theme.dart';

class LoadedThemeData {
  String name;
  Color primaryColor;
  Color cardColor;
  Color highlightColor;
  Color backgroundColor;
  Color secondaryColor;

  Brightness brightness = Brightness.light;

  void recalcCardColor() {
    cardColor = Color.lerp(primaryColor, backgroundColor, 0.8)!;
  }

  LoadedThemeData(
      {required this.name,
      required this.primaryColor,
      required this.secondaryColor})
      : backgroundColor = secondaryColor,
        highlightColor = primaryColor,
        cardColor = Color.lerp(primaryColor, secondaryColor, 0.8)!;

  ThemeData get theme {
    late final ColorScheme scheme;

    if (brightness == Brightness.light) {
      scheme = ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: primaryColor,
        background: backgroundColor,
        surface: primaryColor,
        onPrimary: Colors.black,
        onSurface: Colors.black,
      );
    } else {
      scheme = ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: primaryColor,
        background: backgroundColor,
        surface: primaryColor,
        onPrimary: Colors.white,
        onSurface: Colors.white,
      );
    }

    return ThemeData.from(colorScheme: scheme).copyWith(
        cardColor: cardColor,
        scrollbarTheme: ScrollbarThemeData(
            thumbColor:
                ScrollbarMaterialStateColor(highlightColor, primaryColor)));
  }
}

class VHCBladeTheme {
  String name;
  Color primaryColor;
  Color cardColor;
  Color highlightColor;
  Color backgroundColor;
  Color secondaryColor;

  VHCBladeTheme({
    required this.name,
    required this.primaryColor,
    required this.cardColor,
    required this.highlightColor,
    required this.backgroundColor,
    required this.secondaryColor,
  });
}
