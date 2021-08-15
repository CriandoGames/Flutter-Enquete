import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../pages/login/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          accentColor: primaryColor,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColorDark)),
          inputDecorationTheme: InputDecorationTheme(
              focusColor: primaryColor,
              labelStyle: TextStyle(color: primaryColor),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColorDark)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColorLight)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor)),
              alignLabelWithHint: true),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
            primary: primaryColor,
          ))),
      home: LoginPage(),
    );
  }
}
