// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_board_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TeamBoardList _$$_TeamBoardListFromJson(Map<String, dynamic> json) =>
    _$_TeamBoardList(
      title: json['title'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => TeamBoardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TeamBoardListToJson(_$_TeamBoardList instance) =>
    <String, dynamic>{
      'title': instance.title,
      'items': instance.items,
    };
