import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const royalBlue = Color(0xFF4169E1);
  static const white = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: royalBlue,
      secondary: royalBlue.withAlpha(204), // 0.8 opacity
      surface: white,
      surfaceVariant: Colors.grey[50]!,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: white,
      indicatorColor: royalBlue.withAlpha(26), // 0.1 opacity
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color:
              states.contains(WidgetState.selected) ? royalBlue : Colors.grey,
          fontSize: 12,
        ),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: royalBlue,
      elevation: 0,
    ),
  );
}
