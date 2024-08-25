import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pocket_guide/settings/settings.dart';

/// {@template settings_cubit}
/// Holds all the information regarding app settings and stores them locally
/// {@endtemplate}
class SettingsCubit extends HydratedCubit<Settings> {
  /// {@macro settings_cubit}
  SettingsCubit() : super(Settings.initialSettings);

  /// Updates current Settings with the selected ThemeMode
  void updateTheme(ThemeMode themeMode) =>
      emit(state.copyWith(themeMode: themeMode));

  /// Updates current Settings with the selected Language
  void updateLanguage(Languages language) =>
      emit(state.copyWith(language: language));

  /// Updates current Settings with more logins
  void updateLogins() => emit(state.copyWith(loginTimes: state.loginTimes + 1));

  /// Updates current Settings with more logins
  void updateReviewRequested() =>
      emit(state.copyWith(reviewRequested: !state.reviewRequested));

  @override
  Settings? fromJson(Map<String, dynamic> json) => Settings.fromMap(json);

  @override
  Map<String, dynamic>? toJson(Settings state) => state.toMap();
}
