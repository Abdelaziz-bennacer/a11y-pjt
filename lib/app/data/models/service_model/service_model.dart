import 'package:freezed_annotation/freezed_annotation.dart';


part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
class ServiceModel with _$ServiceModel {
  factory ServiceModel({
    required String uuid,
    required String name,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);
}