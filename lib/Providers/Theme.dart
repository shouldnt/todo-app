import 'package:flutter/cupertino.dart';
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

  apply(Map<String, Color> set) {
    primaryColor = set["primary"];
    backgroundColor = set["background"];
    accentColor = set["accent"];
    textColor = set["text"];
    shadowColor = set["shadow"];
    notifyListeners();
  }
}