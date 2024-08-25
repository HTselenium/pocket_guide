import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// {@template l10n_extension}
/// Grants access to localizations based on current context
///
/// Usage:
/// ```dart
/// final l10n = context.l10n;
/// ```
/// {@endtemplate}
extension AppLocalizationsX on BuildContext {
  /// {@macro l10n_extension}
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// {@template theme_extension}
/// Grants access to theme based on current context
///
/// Usage:
/// ```dart
/// final theme = context.theme;
/// ```
/// {@endtemplate}
extension ThemeDataX on BuildContext {
  /// {@macro theme_extension}
  ThemeData get theme => Theme.of(this);
}

/// {@template is_dark_extension}
/// Lets us know if current theme is dark mode
///
/// Usage:
/// ```dart
/// final theme = context.theme.isDark;
/// ```
/// {@endtemplate}
extension ThemeX on ThemeData {
  /// {@macro is_dark_extension}
  bool get isDark => brightness == Brightness.dark;
}

/// {@template routes_extension}
/// Generates a list of GoRoute from the current AppRoutes
/// as MaterialPage, thanks to the `.route()` method on AppRoutes
///
/// Usage:
/// ```dart
///routes: [
///  AppRoutes.home,
/// // etc...
///].routes
/// // or
/// AppRoutes.all.routes // .all
/// ```
/// {@endtemplate}
extension GoRoutesX on List<AppRoutes> {
  /// {@macro routes_extension}
  List<GoRoute> get routes =>
      List.generate(length, (index) => this[index].route());
}

/// {@template log_extension}
/// Emit a log event of the current object and returns the length
/// {@endtemplate}
extension Log on Object {
  /// {@macro log_extension}
  /// Example:
  /// ```dart
  /// final model = Model();
  /// model.log(); // outputs the model toString in a log event
  ///              //and returns the string length
  /// ```
  int log() {
    final str = toString();
    devtools.log(str);

    // returns the length of the ouput
    return str.length;
  }
}

/// {@template joined_widgets}
/// Adds a specific type of [Widget] in between a list of Widgets
/// This can be usefull to add some height in between Widgets
/// without the need of writing it multiple times
///
/// Example:
/// ```dart
/// [
///  const Text('CARLOS'),
///  const Text('MOBILE SOLUTIONS'),
/// ].joinWithSeparator(const SizedBox(height: 10));
/// ```
/// {@endtemplate}
extension JoinedWidgets on List<Widget> {
  /// {@macro joined_widgets}
  List<Widget> joinWith(Widget? separator) {
    return length > 1
        ? (take(length - 1)
            .map(
              (widget) =>
                  [widget, separator ?? const SizedBox(height: 24, width: 24)],
            )
            .expand((widget) => widget)
            .toList()
          ..add(last))
        : this;
  }
}

/// {@template hex_color}
/// Generate a Color based on a hex string with or without #
///
/// Example:
/// ```dart
///  final color = 'effde1'.toHexColor();
/// ```
/// {@endtemplate}
extension HexColorX on String {
  /// {@macro hex_color}
  Color toHexColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

/// A collection of usefull extensions on [String]
extension StringCasingExtension on String {
  /// Converts the first letter of a [String] into uppercase
  /// or returns '' if null
  ///
  /// Example:
  /// ```dart
  /// 'carlos gutiérrez'.toCapitalized(); // Carlos gutiérrez
  /// ```
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Converts all the first letters of each words of a given [String] into
  /// uppercase
  ///
  /// Example:
  /// ```dart
  /// 'carlos gutiérrez'.toTitleCase(); // Carlos Gutiérrez
  /// ```
  /// See also:
  ///
  ///  * [toCapitalized]
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

/// Collection of extensions on Color
extension VariateColorX on Color {
  /// Darken a color by [percent] amount (100 = black)
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'Percent must be between 1 to 100');

    final f = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }

  /// Lighten a color by [percent] amount (100 = white)
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'Percent must be between 1 to 100');

    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

/// Adds a padding widget on top of current widget
/// Padding default is horizontal default padding
extension PaddedWidgetX on Widget {
  Widget padded([EdgeInsets? padding]) => Padding(
        padding: padding ?? AppTheme.defaultHorizontalScreenPadding,
        child: this,
      );
}

/// Returns the locale for a given theme mode
extension ThemeModeLocaleX on ThemeMode {
  String localeTheme(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case ThemeMode.system:
        return l10n.system;
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
    }
  }
}
