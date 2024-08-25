import 'package:contentful/models/asset.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pocket_guide/contentful/contentful.dart';
import 'package:pocket_guide/contentful/models/assets.dart' as domain;
import 'package:pocket_guide/news/news.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

@freezed
class NewsDTO with _$NewsDTO implements CMSFieldDTO {
  factory NewsDTO({
    required String title,
    required Asset asset,
    required String shortDescription,
    required String description,
    required Map<String, dynamic> content,
    required String timestamp,
    required CMSEntryDTO<CategoryDTO> category,
  }) = _NewsDTO;

  const NewsDTO._();

  factory NewsDTO.fromJson(Map<String, dynamic> json) =>
      _$NewsDTOFromJson(json);

  @override
  News toModel(String id) => News(
        id: id,
        title: title,
        asset: domain.Assets(
          url: asset.fields?.url,
          fallback: 'assets/images/fallbackImage.png',
          type: asset.fields!.type,
        ),
        shortDescription: shortDescription,
        description: description,
        content: content,
        timestamp: timestamp,
        category: category.fields!.toModel(category.sys!.id),
      );
}
