// ignore_for_file: file_names

import 'package:choco_store_staff/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChainStoreTheme {
  ChainStoreTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
        headline6: GoogleFonts.unicaOne(
            fontSize: 16.sp,
            color: const Color.fromRGBO(28, 103, 88, 100),
            fontWeight: FontWeight.bold),
        subtitle1: GoogleFonts.josefinSlab(fontSize: 21.sp),
        bodyText1: GoogleFonts.unicaOne(
            fontSize: 16.sp, color: const Color.fromARGB(251, 2, 56, 47)),
        subtitle2: GoogleFonts.unicaOne(fontSize: 16.sp, color: Colors.white),
        headline5: GoogleFonts.mitr(
            fontSize: 22.sp,
            color: const Color.fromARGB(251, 2, 56, 47),
            fontWeight: FontWeight.bold)),
  );
  static ThemeData dartTheme = ThemeData();
}
