import 'package:freezed_annotation/freezed_annotation.dart';


part 'critere_rgaa_model.freezed.dart';
part 'critere_rgaa_model.g.dart';

@freezed
class CritereRgaaModel with _$CritereRgaaModel {
  factory CritereRgaaModel({
    required int id,
    required String uuid,
    required String name,
    required String number,
    required String thematique,
  }) = _CritereRgaaModel;

  factory CritereRgaaModel.fromJson(Map<String, dynamic> json) => _$CritereRgaaModelFromJson(json);
}
