import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocket_guide/contentful/models/cms_base.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category implements CMSModel {
  const factory Category({
    required String id,
    required String categoryName,
    Color? color,
  }) = _Category;
}
