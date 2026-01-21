import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF162B);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFDAD6);
  static const Color onPrimaryContainer = Color(0xFF410003);

  static const Color secondary = Color(0xFF775653);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDAD6);
  static const Color onSecondaryContainer = Color(0xFF2C1513);

  static const Color tertiary = Color(0xFF755A2F);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFFFDEAD);
  static const Color onTertiaryContainer = Color(0xFF281800);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color surface = Color(0xFFFFFBFF);
  static const Color onSurface = Color(0xFF201A19);
  static const Color surfaceVariant = Color(0xFFF5DDDA);
  static const Color onSurfaceVariant = Color(0xFF534341);

  static const Color outline = Color(0xFF857370);
  static const Color outlineVariant = Color(0xFFD8C2BF);

  static const Color background = Color(0xFFFFFBFF);
  static const Color onBackground = Color(0xFF201A19);

  static const Color inverseSurface = Color(0xFF362F2E);
  static const Color onInverseSurface = Color(0xFFFBEEEC);
  static const Color inversePrimary = Color(0xFFFFB3AC);

  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    shadow: shadow,
    scrim: scrim,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    inversePrimary: inversePrimary,
  );

  static const Color darkPrimary = Color(0xFFFFB3AC);
  static const Color darkOnPrimary = Color(0xFF68000A);
  static const Color darkPrimaryContainer = Color(0xFF930013);
  static const Color darkOnPrimaryContainer = Color(0xFFFFDAD6);

  static const Color darkSecondary = Color(0xFFE7BDB8);
  static const Color darkOnSecondary = Color(0xFF442927);
  static const Color darkSecondaryContainer = Color(0xFF5D3F3C);
  static const Color darkOnSecondaryContainer = Color(0xFFFFDAD6);

  static const Color darkTertiary = Color(0xFFE5C18D);
  static const Color darkOnTertiary = Color(0xFF422C05);
  static const Color darkTertiaryContainer = Color(0xFF5B4319);
  static const Color darkOnTertiaryContainer = Color(0xFFFFDEAD);

  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkOnError = Color(0xFF690005);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);

  static const Color darkSurface = Color(0xFF201A19);
  static const Color darkOnSurface = Color(0xFFEDE0DE);
  static const Color darkSurfaceVariant = Color(0xFF534341);
  static const Color darkOnSurfaceVariant = Color(0xFFD8C2BF);

  static const Color darkOutline = Color(0xFFA08C8A);
  static const Color darkOutlineVariant = Color(0xFF534341);

  static const Color darkBackground = Color(0xFF201A19);
  static const Color darkOnBackground = Color(0xFFEDE0DE);

  static const Color darkInverseSurface = Color(0xFFEDE0DE);
  static const Color darkOnInverseSurface = Color(0xFF362F2E);
  static const Color darkInversePrimary = Color(0xFFBF0021);

  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    primaryContainer: darkPrimaryContainer,
    onPrimaryContainer: darkOnPrimaryContainer,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    secondaryContainer: darkSecondaryContainer,
    onSecondaryContainer: darkOnSecondaryContainer,
    tertiary: darkTertiary,
    onTertiary: darkOnTertiary,
    tertiaryContainer: darkTertiaryContainer,
    onTertiaryContainer: darkOnTertiaryContainer,
    error: darkError,
    onError: darkOnError,
    errorContainer: darkErrorContainer,
    onErrorContainer: darkOnErrorContainer,
    surface: darkSurface,
    onSurface: darkOnSurface,
    surfaceContainerHighest: darkSurfaceVariant,
    onSurfaceVariant: darkOnSurfaceVariant,
    outline: darkOutline,
    outlineVariant: darkOutlineVariant,
    shadow: shadow,
    scrim: scrim,
    inverseSurface: darkInverseSurface,
    onInverseSurface: darkOnInverseSurface,
    inversePrimary: darkInversePrimary,
  );
}
