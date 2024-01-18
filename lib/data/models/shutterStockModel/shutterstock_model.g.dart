// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shutterstock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShutterStockModelAdapter extends TypeAdapter<ShutterStockModel> {
  @override
  final int typeId = 1;

  @override
  ShutterStockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShutterStockModel(
      page: fields[1] as int?,
      perPage: fields[3] as int?,
      totalCount: fields[5] as int?,
      searchId: fields[7] as String?,
      data: (fields[9] as List?)?.cast<Datum>(),
      spellcheckInfo: fields[11] as SpellcheckInfo?,
    );
  }

  @override
  void write(BinaryWriter writer, ShutterStockModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.page)
      ..writeByte(3)
      ..write(obj.perPage)
      ..writeByte(5)
      ..write(obj.totalCount)
      ..writeByte(7)
      ..write(obj.searchId)
      ..writeByte(9)
      ..write(obj.data)
      ..writeByte(11)
      ..write(obj.spellcheckInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShutterStockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DatumAdapter extends TypeAdapter<Datum> {
  @override
  final int typeId = 2;

  @override
  Datum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datum(
      id: fields[1] as String?,
      aspect: fields[3] as double?,
      assets: fields[5] as Assets?,
      contributor: fields[7] as Contributor?,
      description: fields[9] as String?,
      imageType: fields[11] as String?,
      hasModelRelease: fields[13] as bool?,
      mediaType: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Datum obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.aspect)
      ..writeByte(5)
      ..write(obj.assets)
      ..writeByte(7)
      ..write(obj.contributor)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.imageType)
      ..writeByte(13)
      ..write(obj.hasModelRelease)
      ..writeByte(15)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AssetsAdapter extends TypeAdapter<Assets> {
  @override
  final int typeId = 3;

  @override
  Assets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assets(
      preview: fields[1] as HugeThumb?,
      smallThumb: fields[3] as HugeThumb?,
      largeThumb: fields[5] as HugeThumb?,
      hugeThumb: fields[7] as HugeThumb?,
      mosaic: fields[9] as HugeThumb?,
      preview1000: fields[11] as HugeThumb?,
      preview1500: fields[13] as HugeThumb?,
    );
  }

  @override
  void write(BinaryWriter writer, Assets obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.preview)
      ..writeByte(3)
      ..write(obj.smallThumb)
      ..writeByte(5)
      ..write(obj.largeThumb)
      ..writeByte(7)
      ..write(obj.hugeThumb)
      ..writeByte(9)
      ..write(obj.mosaic)
      ..writeByte(11)
      ..write(obj.preview1000)
      ..writeByte(13)
      ..write(obj.preview1500);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HugeThumbAdapter extends TypeAdapter<HugeThumb> {
  @override
  final int typeId = 4;

  @override
  HugeThumb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HugeThumb(
      height: fields[1] as int?,
      url: fields[3] as String?,
      width: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HugeThumb obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.width);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HugeThumbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContributorAdapter extends TypeAdapter<Contributor> {
  @override
  final int typeId = 5;

  @override
  Contributor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contributor(
      id: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Contributor obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContributorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpellcheckInfoAdapter extends TypeAdapter<SpellcheckInfo> {
  @override
  final int typeId = 6;

  @override
  SpellcheckInfo read(BinaryReader reader) {
    return SpellcheckInfo();
  }

  @override
  void write(BinaryWriter writer, SpellcheckInfo obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellcheckInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
