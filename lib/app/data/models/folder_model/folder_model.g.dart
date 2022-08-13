// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FolderModel _$$_FolderModelFromJson(Map<String, dynamic> json) =>
    _$_FolderModel(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      isActif: json['isActif'] as bool,
      projectUUID: json['projectUUID'] as String,
      service: json['service'] as String?,
    );

Map<String, dynamic> _$$_FolderModelToJson(_$_FolderModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'isActif': instance.isActif,
      'projectUUID': instance.projectUUID,
      'service': instance.service,
    };
