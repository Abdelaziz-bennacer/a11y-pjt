
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.acme(color: Color(0xfff44346), fontSize: 50),
      backgroundColor: Color(0xff082D6D),//Colors.transparent, 
    ),
    /*tabBarTheme: const TabBarTheme(
      labelColor: Colors.redAccent,
      unselectedLabelColor: Colors.blueAccent,
    ),*/
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        textStyle: GoogleFonts.acme(),
      )
      ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.roboto(color: Color(0xff082D6D))
      )
    ),
    );

  static final dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black38,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            textStyle: GoogleFonts.acme(),
          )
      )
  );

  static final headerAdminListTextStyle = GoogleFonts.acme(color: const Color(0xfff44346), fontWeight: FontWeight.bold, fontSize: 20);
}
