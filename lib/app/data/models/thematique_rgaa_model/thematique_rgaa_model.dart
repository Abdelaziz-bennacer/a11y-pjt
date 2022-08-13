import 'package:freezed_annotation/freezed_annotation.dart';

import '../critere_rgaa_model/critere_rgaa_model.dart';


part 'thematique_rgaa_model.freezed.dart';
part 'thematique_rgaa_model.g.dart';

@freezed
class ThematiqueRgaaModel with _$ThematiqueRgaaModel {
  factory ThematiqueRgaaModel({
    required int id,
    required String uuid,
    required String name,
    required int number,
    List<CritereRgaaModel>? criteres,
  }) = _ThematiqueRgaaModel;

  factory ThematiqueRgaaModel.fromJson(Map<String, dynamic> json) => _$ThematiqueRgaaModelFromJson(json);
}