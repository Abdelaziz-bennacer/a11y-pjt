import 'package:a11y_pjt/app/data/models/service_model/service_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'folder_model.freezed.dart';
part 'folder_model.g.dart';

@freezed
class FolderModel with _$FolderModel {
  factory FolderModel({
    required String uuid,
    required String name,
    required bool isActif,
    required String projectUUID,
    String? service,
  }) = _FolderModel;

  factory FolderModel.fromJson(Map<String, dynamic> json) => _$FolderModelFromJson(json);
}
// To parse this JSON data, do
//
//     final folder = folderFromJson(jsonString);
/*
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'folder_model.freezed.dart';
part 'folder_model.g.dart';

FolderModel folderFromJson(String str) => FolderModel.fromJson(json.decode(str));

String folderToJson(FolderModel data) => json.encode(data.toJson());

@freezed
abstract class FolderModel with _$FolderModel {
  const factory FolderModel({
    FolderData? data,
    Meta? meta,
  }) = _FolderModel;

  factory FolderModel.fromJson(Map<String, dynamic> json) => _$FolderModelFromJson(json);
}

@freezed
abstract class FolderData with _$FolderData {
  const factory FolderData({
    int? id,
    PurpleAttributes? attributes,
  }) = _FolderData;

  factory FolderData.fromJson(Map<String, dynamic> json) => _$FolderDataFromJson(json);
}

@freezed
abstract class PurpleAttributes with _$PurpleAttributes {
  const factory PurpleAttributes({
    String? uuid,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    bool? isActif,
    String? projectUuid,
    ServiceType? serviceType,
  }) = _PurpleAttributes;

  factory PurpleAttributes.fromJson(Map<String, dynamic> json) => _$PurpleAttributesFromJson(json);
}

@freezed
abstract class ServiceType with _$ServiceType {
  const factory ServiceType({
    ServiceTypeData? data,
  }) = _ServiceType;

  factory ServiceType.fromJson(Map<String, dynamic> json) => _$ServiceTypeFromJson(json);
}

@freezed
abstract class ServiceTypeData with _$ServiceTypeData {
  const factory ServiceTypeData({
    int? id,
    FluffyAttributes? attributes,
  }) = _ServiceTypeData;

  factory ServiceTypeData.fromJson(Map<String, dynamic> json) => _$ServiceTypeDataFromJson(json);
}

@freezed
abstract class FluffyAttributes with _$FluffyAttributes {
  const factory FluffyAttributes({
    String? uuid,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    String? name,
  }) = _FluffyAttributes;

  factory FluffyAttributes.fromJson(Map<String, dynamic> json) => _$FluffyAttributesFromJson(json);
}

@freezed
abstract class Meta with _$Meta {
  const factory Meta() = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}*/
