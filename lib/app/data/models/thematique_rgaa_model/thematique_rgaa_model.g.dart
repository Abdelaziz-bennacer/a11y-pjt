// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thematique_rgaa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ThematiqueRgaaModel _$$_ThematiqueRgaaModelFromJson(
        Map<String, dynamic> json) =>
    _$_ThematiqueRgaaModel(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      number: json['number'] as int,
      criteres: (json['criteres'] as List<dynamic>?)
          ?.map((e) => CritereRgaaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ThematiqueRgaaModelToJson(
        _$_ThematiqueRgaaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'number': instance.number,
      'criteres': instance.criteres,
    };
