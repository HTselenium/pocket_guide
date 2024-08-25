import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

/// Different app theme types for the app
/// Color from:
/// https://smart-swatch.netlify.app/
///
/// Also have a look at:
/// https://tailwindcss.com/docs/customizing-colors
abstract class AppTheme {
  /// Default border Radius
  static final defaultBorderRadius = BorderRadius.circular(Dimens.paddingSemi);

  /// Default screen Padding
  static const defaultScreenPadding = EdgeInsets.symmetric(
    horizontal: Dimens.paddingMedium20,
    vertical: Dimens.paddingMedium,
  );

  /// Default horizontal screen Padding
  static final defaultHorizontalScreenPadding = EdgeInsets.symmetric(
    horizontal: defaultScreenPadding.horizontal,
  );

  /// Default vertical screen Padding
  static final defaultVerticalScreenPadding = EdgeInsets.symmetric(
    vertical: defaultScreenPadding.vertical,
  );

  /// Default light gradient
  static const _defaultGradient = LinearGradient(
    transform: GradientRotation(94.28),
    colors: [
      Color(0xffFFFFFF),
      Color(0xffE0EED2),
    ],
  );
  static const _defaultDarkGradient = LinearGradient(
    transform: GradientRotation(94.28),
    colors: [
      Color(0xFF0F0E0E),
      Color(0x435F605E),
    ],
  );

  /// Dark theme gradient
  static LinearGradient appGradient(ThemeData theme) {
    return theme.isDark ? _defaultDarkGradient : _defaultGradient;
  }

  /// BASF Color
  static const orangeColor = 0xFFF39500;
  static const redColor = 0xFFC50022;
  static const greenColor = 0xFF00793A;
  static const lightBlueColor = 0xFF21A0D2;
  static const lightGreyColor = 0xFFDDDDDD;
  static const greyColor = 0xFF7E7E7E;
  static const blackColor = 0xFF373737;
  static const lightGreenColor = 0xFF65AC1E;

  ///BASF - Dark Blue Swatches
  static const darkBlueColor = 0xFF004a96;
  static final darkBlueSwatch = MaterialColor(darkBlueColor, {
    50: '#d9e4ef'.toHexColor(),
    100: '#ccdbea'.toHexColor(),
    200: '#99b7d5'.toHexColor(),
    300: '#6692c0'.toHexColor(),
    375: '#336eab'.toHexColor(),
    400: '#2665a6'.toHexColor(),
    500: const Color(darkBlueColor),
    600: '#003b78'.toHexColor(),
    700: '#002c5a'.toHexColor(),
    800: '#001e3c'.toHexColor(),
    900: '#000F1E'.toHexColor(),
  });

  static const primaryColor = 0xff65AC1E;
  static final _primarySwatch = MaterialColor(primaryColor, {
    50: '#effde1'.toHexColor(),
    100: '#d8f5bb'.toHexColor(),
    200: '#beec91'.toHexColor(),
    300: '#a6e467'.toHexColor(),
    400: '#8ddd3e'.toHexColor(),
    500: '#59981b'.toHexColor(),
    600: const Color(primaryColor), // indigo-500
    700: '#3f6d11'.toHexColor(),
    800: '#244107'.toHexColor(),
    900: '#091700'.toHexColor(),
  });

  static const _textColor = 0xFF64748B;
  static final _textSwatch = MaterialColor(_textColor, {
    50: 'F8FAFC'.toHexColor(),
    100: 'F1F5F9'.toHexColor(),
    200: 'E2E8F0'.toHexColor(),
    300: 'CBD5E1'.toHexColor(),
    400: '94A3B8'.toHexColor(),
    500: const Color(_textColor),
    600: '475569'.toHexColor(),
    700: '334155'.toHexColor(),
    800: '1E293B'.toHexColor(),
    900: '0F172A'.toHexColor(),
  });

  static const _fontKey = 'Roboto';

  ///Shadow
  static BoxShadow shadow() => BoxShadow(
        color: AppTheme.darkBlueSwatch.shade200.withOpacity(0.4),
        blurRadius: 30,
        offset: const Offset(3, 2),
      );

  // Dark theme styles
  /// Dark theme background
  static Color? darkBackground(ThemeData theme) =>
      theme.isDark ? darkTheme.scaffoldBackgroundColor : null;

  /// Dark theme popups
  static Color? darkPopup(ThemeData theme) =>
      theme.isDark ? Colors.grey.shade700 : null;

  /// Dark theme icons
  static Color? darkIconColor(ThemeData theme) =>
      theme.isDark ? Colors.white : null;

  /// Dark theme text
  static Color? darkTextColor(ThemeData theme) =>
      theme.isDark ? Colors.white : null;

  ///Button style
  static ButtonStyle primaryButtonTheme(ThemeData theme) =>
      ElevatedButton.styleFrom(
        backgroundColor:
            theme.isDark ? darkTheme.scaffoldBackgroundColor : Colors.white,
        minimumSize: const Size(double.infinity, 51),
        maximumSize: const Size(double.infinity, 51),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppTheme.darkBlueSwatch.shade200,
          ),
        ),
        shadowColor: AppTheme.darkBlueSwatch.shade200.withOpacity(0.1),
      ).copyWith(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      );

  /// App light theme
  static ThemeData get lightTheme => ThemeData(
        primaryColor: const Color(AppTheme.lightGreenColor),
        shadowColor: Colors.transparent,
        splashColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey.shade400,
          selectedColor: const Color(primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(primaryColor),
          unselectedItemColor: const Color(primaryColor).withOpacity(0.2),
        ),
        dividerColor: const Color(0x1C000000),
        fontFamily: _fontKey,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: _textSwatch.shade700,
            fontWeight: FontWeight.w300,
            fontFamily: _fontKey,
          ),
          displayMedium: TextStyle(
            color: _textSwatch.shade600,
            fontWeight: FontWeight.w300,
            fontFamily: _fontKey,
          ),
          displaySmall: TextStyle(
            color: _textSwatch.shade700,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          headlineMedium: TextStyle(
            color: _textSwatch.shade700,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          headlineSmall: TextStyle(
            color: _textSwatch.shade600,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          titleLarge: TextStyle(
            color: _textSwatch.shade700,
            fontWeight: FontWeight.w500,
            fontFamily: _fontKey,
          ),
          titleMedium: TextStyle(
            color: _textSwatch.shade700,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          titleSmall: TextStyle(
            color: _textSwatch.shade600,
            fontWeight: FontWeight.w500,
            fontFamily: _fontKey,
          ),
          bodyLarge: TextStyle(
            color: _textSwatch.shade700,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          bodyMedium: TextStyle(
            color: _textSwatch.shade500,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          labelLarge: TextStyle(
            color: _textSwatch.shade500,
            fontWeight: FontWeight.w500,
            fontFamily: _fontKey,
          ),
          bodySmall: TextStyle(
            color: _textSwatch.shade500,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          labelSmall: TextStyle(
            color: _textSwatch.shade500,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.white,
          background: _textSwatch.shade100,
        ),
        primarySwatch: _primarySwatch,
      );

  /// App dark theme
  static ThemeData get darkTheme => lightTheme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF18181B),
        cardColor: const Color(0xFF262626),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF18181B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF18181B),
          selectedItemColor: const Color(primaryColor),
          unselectedItemColor: const Color(primaryColor).withOpacity(0.2),
        ),
        dividerColor: const Color(0x1CFFFFFF),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: _textSwatch.shade200,
            fontWeight: FontWeight.w300,
            fontFamily: _fontKey,
          ),
          displayMedium: TextStyle(
            color: _textSwatch.shade300,
            fontWeight: FontWeight.w300,
            fontFamily: _fontKey,
          ),
          displaySmall: TextStyle(
            color: _textSwatch.shade200,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          headlineMedium: TextStyle(
            color: _textSwatch.shade200,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          headlineSmall: TextStyle(
            color: _textSwatch.shade300,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          titleLarge: TextStyle(
            color: _textSwatch.shade200,
            fontWeight: FontWeight.w500,
            fontFamily: _fontKey,
          ),
          titleMedium: TextStyle(
            color: _textSwatch.shade200,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          titleSmall: TextStyle(
            color: _textSwatch.shade300,
            fontWeight: FontWeight.w500,
            fontFamily: _fontKey,
          ),
          bodyLarge: TextStyle(
            color: _textSwatch.shade300,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          bodyMedium: TextStyle(
            color: _textSwatch.shade200,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          labelLarge: TextStyle(
            color: _textSwatch.shade400,
            fontWeight: FontWeight.w500,
            fontFamily: _fontKey,
          ),
          bodySmall: TextStyle(
            color: _textSwatch.shade400,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
          labelSmall: TextStyle(
            color: _textSwatch.shade400,
            fontWeight: FontWeight.normal,
            fontFamily: _fontKey,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF18181B),
        ),
      );
}
