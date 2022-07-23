// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      firstname: json['firstname'] as String,
      email: json['email'] as String,
      function: json['function'] as String,
      isAdmin: json['isAdmin'] as bool,
      avatarURL: json['avatarURL'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'username': instance.username,
      'name': instance.name,
      'firstname': instance.firstname,
      'email': instance.email,
      'function': instance.function,
      'isAdmin': instance.isAdmin,
      'avatarURL': instance.avatarURL,
    };
