import 'package:a11y_pjt/app/data/models/project_model/project_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  factory CompanyModel({
    required String uuid,
    required String name,
    List<ProjectModel>? projects,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);
}
