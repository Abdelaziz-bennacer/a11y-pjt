import 'package:freezed_annotation/freezed_annotation.dart';


part 'fiche_utile_model.freezed.dart';
part 'fiche_utile_model.g.dart';

@freezed
class FicheUtileModel with _$FicheUtileModel {
  factory FicheUtileModel({
    required int id,
    required String uuid,
    required String thematique,
    required String critere,
    required String critereNo,
    required DateTime createdAt,
    String? url,
    required String title,
    required String problem,
    String? imageUrl1,
    String? imageUrl2,
    required String solution,
    String? code1,
    String? code2,
    required String author,
  }) = _FicheUtileModel;

  factory FicheUtileModel.fromJson(Map<String, dynamic> json) => _$FicheUtileModelFromJson(json);
}