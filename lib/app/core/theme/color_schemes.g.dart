import 'package:flutter/material.dart';

class MyselffTheme {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2D5DA7),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD7E2FF),
    onPrimaryContainer: Color(0xFF001B3F),
    secondary: Color(0xFF565E71),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFDAE2F9),
    onSecondaryContainer: Color(0xFF131C2C),
    tertiary: Color(0xFF00629F),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD0E4FF),
    onTertiaryContainer: Color(0xFF001D34),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFBFF),
    onBackground: Color(0xFF1A1B1F),
    surface: Color(0xFFFDFBFF),
    onSurface: Color(0xFF1A1B1F),
    surfaceVariant: Color(0xFFE0E2EC),
    onSurfaceVariant: Color(0xFF44474E),
    outline: Color(0xFF74777F),
    onInverseSurface: Color(0xFFF2F0F4),
    inverseSurface: Color(0xFF2F3033),
    inversePrimary: Color(0xFFABC7FF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF2D5DA7),
    outlineVariant: Color(0xFFC4C6D0),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFABC7FF),
    onPrimary: Color(0xFF002F66),
    primaryContainer: Color(0xFF06458E),
    onPrimaryContainer: Color(0xFFD7E2FF),
    secondary: Color(0xFFBEC6DC),
    onSecondary: Color(0xFF283041),
    secondaryContainer: Color(0xFF3E4759),
    onSecondaryContainer: Color(0xFFDAE2F9),
    tertiary: Color(0xFF9ACBFF),
    onTertiary: Color(0xFF003355),
    tertiaryContainer: Color(0xFF004A79),
    onTertiaryContainer: Color(0xFFD0E4FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1B1F),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1A1B1F),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF44474E),
    onSurfaceVariant: Color(0xFFC4C6D0),
    outline: Color(0xFF8E9099),
    onInverseSurface: Color(0xFF1A1B1F),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF2D5DA7),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFABC7FF),
    outlineVariant: Color(0xFF44474E),
    scrim: Color(0xFF000000),
  );

  static Color get colorSurface =>
      isDarkMode() ? darkColorScheme.surface : lightColorScheme.surface;

  static Color get outlineColor =>
      isDarkMode() ? darkColorScheme.outline : lightColorScheme.outline;

  static Color get colorPrimary =>
      isDarkMode() ? darkColorScheme.primary : lightColorScheme.primary;

  static Color get errorColor =>
      isDarkMode() ? darkColorScheme.error : lightColorScheme.error;

  static isDarkMode() {
    var brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
}
