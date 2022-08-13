import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../teamboard_item_model/team_board_item_model.dart';


part 'team_board_list_model.freezed.dart';
part 'team_board_list_model.g.dart';

@freezed
class TeamBoardList with _$TeamBoardList {
  factory TeamBoardList({
    //required Widget header,
    required String title,
    required List<TeamBoardItem> items,
  }) = _TeamBoardList;

  factory TeamBoardList.fromJson(Map<String, dynamic> json) => _$TeamBoardListFromJson(json);
}