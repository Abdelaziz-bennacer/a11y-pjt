// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProjectModel _$$_ProjectModelFromJson(Map<String, dynamic> json) =>
    _$_ProjectModel(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      companyUUID: json['companyUUID'] as String,
      folders: (json['folders'] as List<dynamic>?)
          ?.map((e) => FolderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProjectModelToJson(_$_ProjectModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'companyUUID': instance.companyUUID,
      'folders': instance.folders,
    };
