// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'folder_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FolderModel _$FolderModelFromJson(Map<String, dynamic> json) {
  return _FolderModel.fromJson(json);
}

/// @nodoc
mixin _$FolderModel {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isActif => throw _privateConstructorUsedError;
  String get projectUUID => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FolderModelCopyWith<FolderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderModelCopyWith<$Res> {
  factory $FolderModelCopyWith(
          FolderModel value, $Res Function(FolderModel) then) =
      _$FolderModelCopyWithImpl<$Res>;
  $Res call(
      {String uuid,
      String name,
      bool isActif,
      String projectUUID,
      String? service});
}

/// @nodoc
class _$FolderModelCopyWithImpl<$Res> implements $FolderModelCopyWith<$Res> {
  _$FolderModelCopyWithImpl(this._value, this._then);

  final FolderModel _value;
  // ignore: unused_field
  final $Res Function(FolderModel) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = freezed,
    Object? isActif = freezed,
    Object? projectUUID = freezed,
    Object? service = freezed,
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
      isActif: isActif == freezed
          ? _value.isActif
          : isActif // ignore: cast_nullable_to_non_nullable
              as bool,
      projectUUID: projectUUID == freezed
          ? _value.projectUUID
          : projectUUID // ignore: cast_nullable_to_non_nullable
              as String,
      service: service == freezed
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_FolderModelCopyWith<$Res>
    implements $FolderModelCopyWith<$Res> {
  factory _$$_FolderModelCopyWith(
          _$_FolderModel value, $Res Function(_$_FolderModel) then) =
      __$$_FolderModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uuid,
      String name,
      bool isActif,
      String projectUUID,
      String? service});
}

/// @nodoc
class __$$_FolderModelCopyWithImpl<$Res> extends _$FolderModelCopyWithImpl<$Res>
    implements _$$_FolderModelCopyWith<$Res> {
  __$$_FolderModelCopyWithImpl(
      _$_FolderModel _value, $Res Function(_$_FolderModel) _then)
      : super(_value, (v) => _then(v as _$_FolderModel));

  @override
  _$_FolderModel get _value => super._value as _$_FolderModel;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? name = freezed,
    Object? isActif = freezed,
    Object? projectUUID = freezed,
    Object? service = freezed,
  }) {
    return _then(_$_FolderModel(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isActif: isActif == freezed
          ? _value.isActif
          : isActif // ignore: cast_nullable_to_non_nullable
              as bool,
      projectUUID: projectUUID == freezed
          ? _value.projectUUID
          : projectUUID // ignore: cast_nullable_to_non_nullable
              as String,
      service: service == freezed
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FolderModel implements _FolderModel {
  _$_FolderModel(
      {required this.uuid,
      required this.name,
      required this.isActif,
      required this.projectUUID,
      this.service});

  factory _$_FolderModel.fromJson(Map<String, dynamic> json) =>
      _$$_FolderModelFromJson(json);

  @override
  final String uuid;
  @override
  final String name;
  @override
  final bool isActif;
  @override
  final String projectUUID;
  @override
  final String? service;

  @override
  String toString() {
    return 'FolderModel(uuid: $uuid, name: $name, isActif: $isActif, projectUUID: $projectUUID, service: $service)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FolderModel &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.isActif, isActif) &&
            const DeepCollectionEquality()
                .equals(other.projectUUID, projectUUID) &&
            const DeepCollectionEquality().equals(other.service, service));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isActif),
      const DeepCollectionEquality().hash(projectUUID),
      const DeepCollectionEquality().hash(service));

  @JsonKey(ignore: true)
  @override
  _$$_FolderModelCopyWith<_$_FolderModel> get copyWith =>
      __$$_FolderModelCopyWithImpl<_$_FolderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FolderModelToJson(
      this,
    );
  }
}

abstract class _FolderModel implements FolderModel {
  factory _FolderModel(
      {required final String uuid,
      required final String name,
      required final bool isActif,
      required final String projectUUID,
      final String? service}) = _$_FolderModel;

  factory _FolderModel.fromJson(Map<String, dynamic> json) =
      _$_FolderModel.fromJson;

  @override
  String get uuid;
  @override
  String get name;
  @override
  bool get isActif;
  @override
  String get projectUUID;
  @override
  String? get service;
  @override
  @JsonKey(ignore: true)
  _$$_FolderModelCopyWith<_$_FolderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
