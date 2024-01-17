import 'package:json_annotation/json_annotation.dart';
part 'shutterstock_model.g.dart';

@JsonSerializable()
class ShutterStockModel {
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "total_count")
  int? totalCount;
  @JsonKey(name: "search_id")
  String? searchId;
  @JsonKey(name: "data")
  List<Datum>? data;
  @JsonKey(name: "spellcheck_info")
  SpellcheckInfo? spellcheckInfo;

  ShutterStockModel({
    this.page,
    this.perPage,
    this.totalCount,
    this.searchId,
    this.data,
    this.spellcheckInfo,
  });

  ShutterStockModel copyWith({
    int? page,
    int? perPage,
    int? totalCount,
    String? searchId,
    List<Datum>? data,
    SpellcheckInfo? spellcheckInfo,
  }) =>
      ShutterStockModel(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        totalCount: totalCount ?? this.totalCount,
        searchId: searchId ?? this.searchId,
        data: data ?? this.data,
        spellcheckInfo: spellcheckInfo ?? this.spellcheckInfo,
      );

  factory ShutterStockModel.fromJson(Map<String, dynamic> json) => _$ShutterStockModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShutterStockModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "aspect")
  double? aspect;
  @JsonKey(name: "assets")
  Assets? assets;
  @JsonKey(name: "contributor")
  Contributor? contributor;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "image_type")
  String? imageType;
  @JsonKey(name: "has_model_release")
  bool? hasModelRelease;
  @JsonKey(name: "media_type")
  String? mediaType;

  Datum({
    this.id,
    this.aspect,
    this.assets,
    this.contributor,
    this.description,
    this.imageType,
    this.hasModelRelease,
    this.mediaType,
  });

  Datum copyWith({
    String? id,
    double? aspect,
    Assets? assets,
    Contributor? contributor,
    String? description,
    String? imageType,
    bool? hasModelRelease,
    String? mediaType,
  }) =>
      Datum(
        id: id ?? this.id,
        aspect: aspect ?? this.aspect,
        assets: assets ?? this.assets,
        contributor: contributor ?? this.contributor,
        description: description ?? this.description,
        imageType: imageType ?? this.imageType,
        hasModelRelease: hasModelRelease ?? this.hasModelRelease,
        mediaType: mediaType ?? this.mediaType,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Assets {
  @JsonKey(name: "preview")
  HugeThumb? preview;
  @JsonKey(name: "small_thumb")
  HugeThumb? smallThumb;
  @JsonKey(name: "large_thumb")
  HugeThumb? largeThumb;
  @JsonKey(name: "huge_thumb")
  HugeThumb? hugeThumb;
  @JsonKey(name: "mosaic")
  HugeThumb? mosaic;
  @JsonKey(name: "preview_1000")
  HugeThumb? preview1000;
  @JsonKey(name: "preview_1500")
  HugeThumb? preview1500;

  Assets({
    this.preview,
    this.smallThumb,
    this.largeThumb,
    this.hugeThumb,
    this.mosaic,
    this.preview1000,
    this.preview1500,
  });

  Assets copyWith({
    HugeThumb? preview,
    HugeThumb? smallThumb,
    HugeThumb? largeThumb,
    HugeThumb? hugeThumb,
    HugeThumb? mosaic,
    HugeThumb? preview1000,
    HugeThumb? preview1500,
  }) =>
      Assets(
        preview: preview ?? this.preview,
        smallThumb: smallThumb ?? this.smallThumb,
        largeThumb: largeThumb ?? this.largeThumb,
        hugeThumb: hugeThumb ?? this.hugeThumb,
        mosaic: mosaic ?? this.mosaic,
        preview1000: preview1000 ?? this.preview1000,
        preview1500: preview1500 ?? this.preview1500,
      );

  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsToJson(this);
}

@JsonSerializable()
class HugeThumb {
  @JsonKey(name: "height")
  int? height;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "width")
  int? width;

  HugeThumb({
    this.height,
    this.url,
    this.width,
  });

  HugeThumb copyWith({
    int? height,
    String? url,
    int? width,
  }) =>
      HugeThumb(
        height: height ?? this.height,
        url: url ?? this.url,
        width: width ?? this.width,
      );

  factory HugeThumb.fromJson(Map<String, dynamic> json) => _$HugeThumbFromJson(json);

  Map<String, dynamic> toJson() => _$HugeThumbToJson(this);
}

@JsonSerializable()
class Contributor {
  @JsonKey(name: "id")
  String? id;

  Contributor({
    this.id,
  });

  Contributor copyWith({
    String? id,
  }) =>
      Contributor(
        id: id ?? this.id,
      );

  factory Contributor.fromJson(Map<String, dynamic> json) => _$ContributorFromJson(json);

  Map<String, dynamic> toJson() => _$ContributorToJson(this);
}

@JsonSerializable()
class SpellcheckInfo {
  SpellcheckInfo();

factory SpellcheckInfo.fromJson(Map<String, dynamic> json) => _$SpellcheckInfoFromJson(json);

Map<String, dynamic> toJson() => _$SpellcheckInfoToJson(this);
}
