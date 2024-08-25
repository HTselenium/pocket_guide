import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class InitialLayoutModel extends Equatable {
  const InitialLayoutModel({
    required this.industryTypeIndex,
    required this.buttonClickState,
  });

  factory InitialLayoutModel.fromMap(Map<String, dynamic> map) {
    return InitialLayoutModel(
      industryTypeIndex: map[_industryTypeIndexKey] as int,
      buttonClickState: map[_buttonClickStateKey] as bool,
    );
  }

  factory InitialLayoutModel.fromJson(String source) =>
      InitialLayoutModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static const initialInitialLayout = InitialLayoutModel(
    industryTypeIndex: 0,
    buttonClickState: false,
  );
  final int industryTypeIndex;
  final bool buttonClickState;

  static const _industryTypeIndexKey = 'industryTypeIndex';
  static const _buttonClickStateKey = 'buttonClickState';

  InitialLayoutModel copyWith({
    int? industryTypeIndex,
    bool? buttonClickState,
  }) {
    return InitialLayoutModel(
      industryTypeIndex: industryTypeIndex ?? this.industryTypeIndex,
      buttonClickState: buttonClickState ?? this.buttonClickState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _industryTypeIndexKey: industryTypeIndex,
      _buttonClickStateKey: buttonClickState,
    };
  }
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [industryTypeIndex, buttonClickState];
}
