import 'package:contentful/models/entry.dart';
import 'package:contentful/models/system_fields.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocket_guide/contentful/dtos/cms_field_dto.dart';
import 'package:pocket_guide/contentful/models/cms_base.dart';
import 'package:pocket_guide/core/core.dart';

part 'cms_entry_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CMSEntryDTO<T extends CMSFieldDTO> extends Entry<T> {
  CMSEntryDTO({
    required SystemFields super.sys,
    required super.fields,
  });

  factory CMSEntryDTO.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$CMSEntryDTOFromJson<T>(json, fromJsonT);

  static CMSEntryDTO<T> Function(Map<String, dynamic> json)
      fromJsonWithParser<T extends CMSFieldDTO>(
    T Function(Map<String, dynamic>) fromJson,
  ) =>
          (json) => CMSEntryDTO.fromJson(
                json,
                (o) => fromJson(o! as Map<String, dynamic>),
              );

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$CMSEntryDTOToJson<T>(this, toJsonT);
}

extension CMSEntryDtoExt<T extends CMSFieldDTO> on CMSEntryDTO<T> {
  CMSModel? toModel() => fields?.let((it) => it.toModel(sys!.id));
}
