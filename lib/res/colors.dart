import 'package:flutter/material.dart';

///颜色常量维护
class _Colours {
  static const Color app_main = Color(0xFF666666);
  static const Color gray_33 = Color(0xFF333333); //51
}

//主题颜色
Map<String, Color> themeColorMap = {
  'gray': _Colours.gray_33,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.deepPurple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.deepOrange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};
