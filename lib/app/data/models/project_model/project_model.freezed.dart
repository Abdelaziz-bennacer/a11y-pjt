// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return _ProjectModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectModel {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get companyUUID => throw _privateConstructorUsedError;
  List<FolderModel>? get folders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
          ProjectModel value, $Res Function(ProjectModel) then) =
      _$ProjectModelCopyWithImpl<$Res>;
  $Res call(
      {String uuid,
      String name,
      String companyUUID,
      List<FolderModel>? folders});
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res> implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  final ProjectModel _value;
  // ignore: unused_field
  final $Res Function(ProjectModel) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = freezed,
    Object? companyUUID = freezed,
    Object? folders = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      companyUUID: companyUUID == freezed
          ? _value.companyUUID
          : companyUUID // ignore: cast_nullable_to_non_nullable
              as String,
      folders: folders == freezed
          ? _value.folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<FolderModel>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProjectModelCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$_ProjectModelCopyWith(
          _$_ProjectModel value, $Res Function(_$_ProjectModel) then) =
      __$$_ProjectModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uuid,
      String name,
      String companyUUID,
      List<FolderModel>? folders});
}

/// @nodoc
class __$$_ProjectModelCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res>
    implements _$$_ProjectModelCopyWith<$Res> {
  __$$_ProjectModelCopyWithImpl(
      _$_ProjectModel _value, $Res Function(_$_ProjectModel) _then)
      : super(_value, (v) => _then(v as _$_ProjectModel));

  @override
  _$_ProjectModel get _value => super._value as _$_ProjectModel;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = freezed,
    Object? companyUUID = freezed,
    Object? folders = freezed,
  }) {
    return _then(_$_ProjectModel(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      companyUUID: companyUUID == freezed
          ? _value.companyUUID
          : companyUUID // ignore: cast_nullable_to_non_nullable
              as String,
      folders: folders == freezed
          ? _value._folders
          : folders // ignore: cast_nullable_to_non_nullable
              as List<FolderModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectModel implements _ProjectModel {
  _$_ProjectModel(
      {required this.uuid,
      required this.name,
      required this.companyUUID,
      final List<FolderModel>? folders})
      : _folders = folders;

  factory _$_ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectModelFromJson(json);

  @override
  final String uuid;
  @override
  final String name;
  @override
  final String companyUUID;
  final List<FolderModel>? _folders;
  @override
  List<FolderModel>? get folders {
    final value = _folders;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProjectModel(uuid: $uuid, name: $name, companyUUID: $companyUUID, folders: $folders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectModel &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.companyUUID, companyUUID) &&
            const DeepCollectionEquality().equals(other._folders, _folders));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(companyUUID),
      const DeepCollectionEquality().hash(_folders));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectModelCopyWith<_$_ProjectModel> get copyWith =>
      __$$_ProjectModelCopyWithImpl<_$_ProjectModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectModelToJson(
      this,
    );
  }
}

abstract class _ProjectModel implements ProjectModel {
  factory _ProjectModel(
      {required final String uuid,
      required final String name,
      required final String companyUUID,
      final List<FolderModel>? folders}) = _$_ProjectModel;

  factory _ProjectModel.fromJson(Map<String, dynamic> json) =
      _$_ProjectModel.fromJson;

  @override
  String get uuid;
  @override
  String get name;
  @override
  String get companyUUID;
  @override
  List<FolderModel>? get folders;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectModelCopyWith<_$_ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}
