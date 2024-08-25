abstract class CMSModel {
  factory CMSModel.unsupported(String id, [Map<String, dynamic>? data]) =
      CMSUnsupportedModel;
}

class CMSUnsupportedModel implements CMSModel {
  const CMSUnsupportedModel([this.id, this.data]);

  final String? id;
  final Map<String, dynamic>? data;
}
