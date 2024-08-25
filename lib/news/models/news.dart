import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocket_guide/contentful/contentful.dart';
import 'package:pocket_guide/news/news.dart';

part 'news.freezed.dart';

@freezed
class News with _$News implements CMSModel {
  const factory News({
    required String id,
    required String title,
    required Assets asset,
    required String shortDescription,
    required String description,
    required Map<String, dynamic> content,
    required String timestamp,
    required Category category,
    int? number,
  }) = _News;
}
