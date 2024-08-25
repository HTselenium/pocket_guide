// ignore_for_file: public_member_api_docs
// ignore_for_file: sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:pocket_guide/settings/settings.dart';

/// {@template settings}
/// Current settings of the user
/// {@endtemplate}
@immutable
class Settings extends Equatable {
  /// {@macro settings}
  const Settings({
    required this.themeMode,
    required this.language,
    required this.loginTimes,
    required this.reviewRequested,
  });

  /// Default settings the app should have
  static const initialSettings = Settings(
    // Thememode will default to System
    themeMode: ThemeMode.system,
    // Language will be null, so the app locale will default to the device one
    language: Languages.english,
    // At start, 0 login times to the app has ocurred
    loginTimes: 0,
    // We wont ask for a review at start
    reviewRequested: false,
  );

  /// ThemeMode of the application
  // enum
  final ThemeMode themeMode;

  /// Language of the application
  // enum
  final Languages language;

  // Ammount of times the user has logged in
  final int loginTimes;

  // Wether or not we have already asked for a review
  final bool reviewRequested;

  // Keys used to encode/decode to/from json
  static const _themeModeKey = 'themeMode';
  static const _languageKey = 'language';
  static const _loginTimesKey = 'loginTimes';
  static const _reviewRequestedKey = 'reviewRequested';

  Settings copyWith({
    ThemeMode? themeMode,
    Languages? language,
    int? loginTimes,
    bool? reviewRequested,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      loginTimes: loginTimes ?? this.loginTimes,
      reviewRequested: reviewRequested ?? this.reviewRequested,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _themeModeKey: themeMode.index,
      _languageKey: language.index,
      _loginTimesKey: loginTimes,
      _reviewRequestedKey: reviewRequested,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      themeMode: ThemeMode.values[map[_themeModeKey] as int],
      language: Languages.all[map[_languageKey] as int],
      loginTimes: map[_loginTimesKey] as int,
      reviewRequested: map[_reviewRequestedKey] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        themeMode,
        language,
        loginTimes,
        reviewRequested,
      ];
}
