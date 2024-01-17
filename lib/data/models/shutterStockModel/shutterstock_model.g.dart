// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shutterstock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShutterStockModel _$ShutterStockModelFromJson(Map<String, dynamic> json) =>
    ShutterStockModel(
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
      totalCount: json['total_count'] as int?,
      searchId: json['search_id'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      spellcheckInfo: json['spellcheck_info'] == null
          ? null
          : SpellcheckInfo.fromJson(
              json['spellcheck_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShutterStockModelToJson(ShutterStockModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'total_count': instance.totalCount,
      'search_id': instance.searchId,
      'data': instance.data,
      'spellcheck_info': instance.spellcheckInfo,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: json['id'] as String?,
      aspect: (json['aspect'] as num?)?.toDouble(),
      assets: json['assets'] == null
          ? null
          : Assets.fromJson(json['assets'] as Map<String, dynamic>),
      contributor: json['contributor'] == null
          ? null
          : Contributor.fromJson(json['contributor'] as Map<String, dynamic>),
      description: json['description'] as String?,
      imageType: json['image_type'] as String?,
      hasModelRelease: json['has_model_release'] as bool?,
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'aspect': instance.aspect,
      'assets': instance.assets,
      'contributor': instance.contributor,
      'description': instance.description,
      'image_type': instance.imageType,
      'has_model_release': instance.hasModelRelease,
      'media_type': instance.mediaType,
    };

Assets _$AssetsFromJson(Map<String, dynamic> json) => Assets(
      preview: json['preview'] == null
          ? null
          : HugeThumb.fromJson(json['preview'] as Map<String, dynamic>),
      smallThumb: json['small_thumb'] == null
          ? null
          : HugeThumb.fromJson(json['small_thumb'] as Map<String, dynamic>),
      largeThumb: json['large_thumb'] == null
          ? null
          : HugeThumb.fromJson(json['large_thumb'] as Map<String, dynamic>),
      hugeThumb: json['huge_thumb'] == null
          ? null
          : HugeThumb.fromJson(json['huge_thumb'] as Map<String, dynamic>),
      mosaic: json['mosaic'] == null
          ? null
          : HugeThumb.fromJson(json['mosaic'] as Map<String, dynamic>),
      preview1000: json['preview_1000'] == null
          ? null
          : HugeThumb.fromJson(json['preview_1000'] as Map<String, dynamic>),
      preview1500: json['preview_1500'] == null
          ? null
          : HugeThumb.fromJson(json['preview_1500'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetsToJson(Assets instance) => <String, dynamic>{
      'preview': instance.preview,
      'small_thumb': instance.smallThumb,
      'large_thumb': instance.largeThumb,
      'huge_thumb': instance.hugeThumb,
      'mosaic': instance.mosaic,
      'preview_1000': instance.preview1000,
      'preview_1500': instance.preview1500,
    };

HugeThumb _$HugeThumbFromJson(Map<String, dynamic> json) => HugeThumb(
      height: json['height'] as int?,
      url: json['url'] as String?,
      width: json['width'] as int?,
    );

Map<String, dynamic> _$HugeThumbToJson(HugeThumb instance) => <String, dynamic>{
      'height': instance.height,
      'url': instance.url,
      'width': instance.width,
    };

Contributor _$ContributorFromJson(Map<String, dynamic> json) => Contributor(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ContributorToJson(Contributor instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SpellcheckInfo _$SpellcheckInfoFromJson(Map<String, dynamic> json) =>
    SpellcheckInfo();

Map<String, dynamic> _$SpellcheckInfoToJson(SpellcheckInfo instance) =>
    <String, dynamic>{};
