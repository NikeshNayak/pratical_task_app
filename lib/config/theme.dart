import 'package:flutter/material.dart';

MaterialColor _primarySwatch = const MaterialColor(0xFF212121, <int, Color>{
  50: Color(0xFFE0E0E0),
  100: Color(0xFFB3B3B3),
  200: Color(0xFF808080),
  300: Color(0xFF4D4D4D),
  400: Color(0xFF262626),
  500: Color(0xFF212121),
  600: Color(0xFF1E1E1E),
  700: Color(0xFF1A1A1A),
  800: Color(0xFF141414),
  900: Color(0xFF0D0D0D),
});

ThemeData theme() {
  return ThemeData(
    primarySwatch: _primarySwatch,
    fontFamily: 'Montserrat',
    useMaterial3: false,
  );
}
