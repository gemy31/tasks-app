import 'package:flutter/material.dart';

class MyThemeData {
  static Color primaryblue = const Color(0xFF5D9CEC);
  static Color primarydark = const Color(0xFF060E1E);
  static Color green = const Color(0xFF61E757);
  static Color red = const Color(0xFFEC4B4B);
  static Color blackColor = const Color(0xFF383838);
  static Color darkBlueColor = const Color(0xFF5D9CEC);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color background = const Color(0xFFDFECDB);
  static Color backgroundDark = const Color(0xFF141922);

  static ThemeData lightMood = ThemeData(
    appBarTheme: AppBarTheme(
      color: primaryblue,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        displayLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryblue,
      unselectedItemColor: blackColor,
    ),
  );
  static ThemeData darkMood = ThemeData(
    appBarTheme: AppBarTheme(
      color: darkBlueColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        displayLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: blackColor,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: darkBlueColor,
      unselectedItemColor: Colors.black,
    ),
  );
}
