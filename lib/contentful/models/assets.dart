import 'package:freezed_annotation/freezed_annotation.dart';

part 'assets.freezed.dart';

enum AssetType { image, unknown }

@freezed
class Assets with _$Assets {
  factory Assets({Uri? url, required String fallback, AssetType? type}) =
      _Assets;
}
