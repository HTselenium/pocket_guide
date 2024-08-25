import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_request_dto.freezed.dart';

part 'news_request_dto.g.dart';

@freezed
class NewsRequestDTO with _$NewsRequestDTO {
  factory NewsRequestDTO({
    @Default('news') @JsonKey(name: 'content_type') String contentType,
    @Default('1') String? limit,
    // @Default('en-US') String locale,
    @Default('-sys.updatedAt') String order,
  }) = _NewsRequestDTO;

  factory NewsRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$NewsRequestDTOFromJson(json);
}
