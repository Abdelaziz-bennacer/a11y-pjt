// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fiche_utile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FicheUtileModel _$$_FicheUtileModelFromJson(Map<String, dynamic> json) =>
    _$_FicheUtileModel(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      thematique: json['thematique'] as String,
      critere: json['critere'] as String,
      critereNo: json['critereNo'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      url: json['url'] as String?,
      title: json['title'] as String,
      problem: json['problem'] as String,
      imageUrl1: json['imageUrl1'] as String?,
      imageUrl2: json['imageUrl2'] as String?,
      solution: json['solution'] as String,
      code1: json['code1'] as String?,
      code2: json['code2'] as String?,
      author: json['author'] as String,
    );

Map<String, dynamic> _$$_FicheUtileModelToJson(_$_FicheUtileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'thematique': instance.thematique,
      'critere': instance.critere,
      'critereNo': instance.critereNo,
      'createdAt': instance.createdAt.toIso8601String(),
      'url': instance.url,
      'title': instance.title,
      'problem': instance.problem,
      'imageUrl1': instance.imageUrl1,
      'imageUrl2': instance.imageUrl2,
      'solution': instance.solution,
      'code1': instance.code1,
      'code2': instance.code2,
      'author': instance.author,
    };
