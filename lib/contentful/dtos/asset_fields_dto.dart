import 'package:contentful/contentful.dart';
import 'package:pocket_guide/contentful/models/assets.dart';
import 'package:pocket_guide/core/utils/scope_function.dart';

extension AssetFieldExt on AssetFields {
  Uri? get url => file!.url.let((it) => Uri.parse('https:$it'));

  Uri? getUrlWithSize({int? width, int? height}) {
    final queryParams = <String, String>{};
    width?.let((it) => queryParams['w'] = it.toString());
    height?.let((it) => queryParams['h'] = it.toString());
    return url?.replace(queryParameters: queryParams);
  }

  AssetType get type {
    if (file!.contentType.contains('image')) {
      return AssetType.image;
    }
    return AssetType.unknown;
  }
}
