import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
const Map<String, Color> set1 = {
  "primary": Color(0xff272737),
  "background": Color(0xff191927),
  "accent": Color(0xff4AA5AE),
  "text": Color(0xffD0D0D0),
  "shadow": Color.fromARGB(30, 0, 0, 0)
};
const Map<String, Color> set2 = {
  "primary": Color(0xff4d74c9),
  "background": Color(0xff191927),
  "accent": Color(0xff4AA5AE),
  "text": Color(0xffD0D0D0),
  "shadow": Color.fromARGB(30, 0, 0, 0)
};
class ThemeModel extends ChangeNotifier {
  Color primaryColor = set1["primary"];
  Color backgroundColor = set1["background"];
  Color accentColor = set1["accent"];
  Color textColor = set1["text"];
  Color shadowColor = set1["shadow"];
  Color errorColor = Colors.red;
  Color lowPriorityColor = Colors.green;
  Color mediumPriorityColor = Colors.yellow;
  Color highPriorityColor = Colors.red;
  Color nullPriorityColor = Color(0xff3F3F5A);
  ColorScheme colorScheme;

  ThemeModel() {
    colorScheme = new ColorScheme(
        primary: this.primaryColor,
        primaryVariant: this.primaryColor,
        secondary: this.accentColor,
        secondaryVariant: this.accentColor,
        surface: this.backgroundColor,
        background: this.backgroundColor,
        error: this.errorColor,
        brightness: Brightness.dark,
        onSurface: this.accentColor,
        onSecondary: this.accentColor,
        onError: this.accentColor,
        onPrimary: this.accentColor,
        onBackground: this.accentColor
    );
  }

  apply(Map<String, Color> set) {
    notifyListeners();
  }
}