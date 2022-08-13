import 'package:freezed_annotation/freezed_annotation.dart';


part 'team_board_item_model.freezed.dart';
part 'team_board_item_model.g.dart';

@freezed
class TeamBoardItem with _$TeamBoardItem {
  factory TeamBoardItem({
    required String title,
    required String urlImage,
  }) = _TeamBoardItem;

  factory TeamBoardItem.fromJson(Map<String, dynamic> json) => _$TeamBoardItemFromJson(json);
}