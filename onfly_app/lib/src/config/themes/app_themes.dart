import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.lightBlue,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.lightBlue,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      );
}
