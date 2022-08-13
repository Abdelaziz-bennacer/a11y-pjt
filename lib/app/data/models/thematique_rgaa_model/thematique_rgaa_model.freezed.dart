// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'thematique_rgaa_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ThematiqueRgaaModel _$ThematiqueRgaaModelFromJson(Map<String, dynamic> json) {
  return _ThematiqueRgaaModel.fromJson(json);
}

/// @nodoc
mixin _$ThematiqueRgaaModel {
  int get id => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  List<CritereRgaaModel>? get criteres => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThematiqueRgaaModelCopyWith<ThematiqueRgaaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThematiqueRgaaModelCopyWith<$Res> {
  factory $ThematiqueRgaaModelCopyWith(
          ThematiqueRgaaModel value, $Res Function(ThematiqueRgaaModel) then) =
      _$ThematiqueRgaaModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String uuid,
      String name,
      int number,
      List<CritereRgaaModel>? criteres});
}

/// @nodoc
class _$ThematiqueRgaaModelCopyWithImpl<$Res>
    implements $ThematiqueRgaaModelCopyWith<$Res> {
  _$ThematiqueRgaaModelCopyWithImpl(this._value, this._then);

  final ThematiqueRgaaModel _value;
  // ignore: unused_field
  final $Res Function(ThematiqueRgaaModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? number = freezed,
    Object? criteres = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      criteres: criteres == freezed
          ? _value.criteres
          : criteres // ignore: cast_nullable_to_non_nullable
              as List<CritereRgaaModel>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ThematiqueRgaaModelCopyWith<$Res>
    implements $ThematiqueRgaaModelCopyWith<$Res> {
  factory _$$_ThematiqueRgaaModelCopyWith(_$_ThematiqueRgaaModel value,
          $Res Function(_$_ThematiqueRgaaModel) then) =
      __$$_ThematiqueRgaaModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String uuid,
      String name,
      int number,
      List<CritereRgaaModel>? criteres});
}

/// @nodoc
class __$$_ThematiqueRgaaModelCopyWithImpl<$Res>
    extends _$ThematiqueRgaaModelCopyWithImpl<$Res>
    implements _$$_ThematiqueRgaaModelCopyWith<$Res> {
  __$$_ThematiqueRgaaModelCopyWithImpl(_$_ThematiqueRgaaModel _value,
      $Res Function(_$_ThematiqueRgaaModel) _then)
      : super(_value, (v) => _then(v as _$_ThematiqueRgaaModel));

  @override
  _$_ThematiqueRgaaModel get _value => super._value as _$_ThematiqueRgaaModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? number = freezed,
    Object? criteres = freezed,
  }) {
    return _then(_$_ThematiqueRgaaModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      criteres: criteres == freezed
          ? _value._criteres
          : criteres // ignore: cast_nullable_to_non_nullable
              as List<CritereRgaaModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ThematiqueRgaaModel implements _ThematiqueRgaaModel {
  _$_ThematiqueRgaaModel(
      {required this.id,
      required this.uuid,
      required this.name,
      required this.number,
      final List<CritereRgaaModel>? criteres})
      : _criteres = criteres;

  factory _$_ThematiqueRgaaModel.fromJson(Map<String, dynamic> json) =>
      _$$_ThematiqueRgaaModelFromJson(json);

  @override
  final int id;
  @override
  final String uuid;
  @override
  final String name;
  @override
  final int number;
  final List<CritereRgaaModel>? _criteres;
  @override
  List<CritereRgaaModel>? get criteres {
    final value = _criteres;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ThematiqueRgaaModel(id: $id, uuid: $uuid, name: $name, number: $number, criteres: $criteres)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThematiqueRgaaModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other._criteres, _criteres));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(_criteres));

  @JsonKey(ignore: true)
  @override
  _$$_ThematiqueRgaaModelCopyWith<_$_ThematiqueRgaaModel> get copyWith =>
      __$$_ThematiqueRgaaModelCopyWithImpl<_$_ThematiqueRgaaModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThematiqueRgaaModelToJson(
      this,
    );
  }
}

abstract class _ThematiqueRgaaModel implements ThematiqueRgaaModel {
  factory _ThematiqueRgaaModel(
      {required final int id,
      required final String uuid,
      required final String name,
      required final int number,
      final List<CritereRgaaModel>? criteres}) = _$_ThematiqueRgaaModel;

  factory _ThematiqueRgaaModel.fromJson(Map<String, dynamic> json) =
      _$_ThematiqueRgaaModel.fromJson;

  @override
  int get id;
  @override
  String get uuid;
  @override
  String get name;
  @override
  int get number;
  @override
  List<CritereRgaaModel>? get criteres;
  @override
  @JsonKey(ignore: true)
  _$$_ThematiqueRgaaModelCopyWith<_$_ThematiqueRgaaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
