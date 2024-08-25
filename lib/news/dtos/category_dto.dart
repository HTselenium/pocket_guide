import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocket_guide/contentful/contentful.dart';
import 'package:pocket_guide/news/news.dart';
import 'package:pocket_guide/product_details/product_details.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@freezed
class CategoryDTO with _$CategoryDTO implements CMSFieldDTO {
  factory CategoryDTO({
    required String categoryName,
    required String color,
  }) = _CategoryDTO;

  const CategoryDTO._();

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  @override
  Category toModel(String id) => Category(
        id: id,
        categoryName: categoryName,
        color: _getColor(color),
      );

  Color? _getColor(String category) {
    if (category == 'BASF_Blue') {
      return ProductCategory.categoryDarkBlue.color;
    } else if (category == 'BASF_Light_Blue') {
      return ProductCategory.categoryLightBlue.color;
    } else if (category == 'BASF_Green') {
      return ProductCategory.categoryGreen.color;
    } else if (category == 'BASF_Red') {
      return ProductCategory.categoryRed.color;
    } else if (category == 'BASF_Orange') {
      return ProductCategory.categoryOrange.color;
    } else {
      return ProductCategory.categoryLightGreen.color;
    }
  }
}
