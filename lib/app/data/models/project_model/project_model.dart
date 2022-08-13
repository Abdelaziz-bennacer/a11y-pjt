import 'package:freezed_annotation/freezed_annotation.dart';

import '../folder_model/folder_model.dart';


part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  factory ProjectModel({
    required String uuid,
    required String name,
    required String companyUUID,
    List<FolderModel>? folders,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);
}
