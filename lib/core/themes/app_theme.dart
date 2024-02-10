import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color.fromARGB(255, 247, 254, 255);
  static Color lightPrimaryColor = const Color.fromARGB(255, 15, 56, 131);
  static Color lightAccentColor = const Color.fromARGB(255, 141, 162, 206);
  static Color lightParticlesColor = const Color.fromARGB(255, 68, 75, 83);

  static Color darkBackgroundColor = const Color.fromARGB(255, 53, 53, 58);
  static Color darkPrimaryColor = const Color.fromARGB(255, 110, 113, 211);
  static Color darkAccentColor = const Color.fromARGB(255, 86, 89, 116);
  static Color darkParticlesColor = const Color.fromARGB(255, 155, 151, 184);

  const AppTheme._();
  static final lightTheme = ThemeData(
    // brightness: Brightness.light,
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cairo(
        fontSize: 80,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.cairo(fontSize: 18, color: Colors.black87),
    ),
    colorScheme: lightThemeColors(),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    colorScheme: darkThemeColors(),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cairo(
        fontSize: 80,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.cairo(
        fontSize: 18,
        color: Colors.white60,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ColorScheme lightThemeColors() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: lightPrimaryColor,
      onPrimary: const Color(0xFF505050),
      secondary: lightAccentColor,
      onSecondary: const Color(0xFFEAEAEA),
      error: const Color(0xFFF32424),
      onError: const Color(0xFFF32424),
      background: lightBackgroundColor,
      onBackground: const Color(0xFFFFFFFF),
      surface: lightBackgroundColor,
      onSurface: lightPrimaryColor,
    );
  }

  static ColorScheme darkThemeColors() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: darkPrimaryColor,
      onPrimary: const Color(0xFFFFFFFF),
      secondary: darkAccentColor,
      onSecondary: const Color(0xFFEAEAEA),
      error: const Color(0xFFF32424),
      onError: const Color(0xFFF32424),
      background: darkBackgroundColor,
      onBackground: const Color.fromARGB(255, 59, 49, 49),
      surface: darkBackgroundColor,
      onSurface: darkPrimaryColor,
    );
  }

  static setStatusbarAndNavBarColors(ThemeMode mode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          mode == ThemeMode.light ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          mode == ThemeMode.light ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          mode == ThemeMode.light ? lightBackgroundColor : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
