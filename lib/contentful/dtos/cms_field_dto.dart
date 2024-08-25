import 'package:pocket_guide/contentful/models/cms_base.dart';

abstract class CMSFieldDTO<T extends CMSModel> {
  T? toModel(String id) => null;
}

class CMSUnknownFieldDto implements CMSFieldDTO {
  const CMSUnknownFieldDto([this.id, this.data]);

  factory CMSUnknownFieldDto.fromJson([Map<String, dynamic>? json]) =>
      CMSUnknownFieldDto(json?['sys.id'].toString(), json);

  final Map<String, dynamic>? data;
  final String? id;

  @override
  CMSModel toModel(String id) => CMSModel.unsupported(id, data);
}
