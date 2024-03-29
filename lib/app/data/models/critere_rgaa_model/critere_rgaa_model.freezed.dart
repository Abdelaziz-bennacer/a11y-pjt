// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'critere_rgaa_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CritereRgaaModel _$CritereRgaaModelFromJson(Map<String, dynamic> json) {
  return _CritereRgaaModel.fromJson(json);
}

/// @nodoc
mixin _$CritereRgaaModel {
  int get id => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get thematique => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CritereRgaaModelCopyWith<CritereRgaaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CritereRgaaModelCopyWith<$Res> {
  factory $CritereRgaaModelCopyWith(
          CritereRgaaModel value, $Res Function(CritereRgaaModel) then) =
      _$CritereRgaaModelCopyWithImpl<$Res>;
  $Res call(
      {int id, String uuid, String name, String number, String thematique});
}

/// @nodoc
class _$CritereRgaaModelCopyWithImpl<$Res>
    implements $CritereRgaaModelCopyWith<$Res> {
  _$CritereRgaaModelCopyWithImpl(this._value, this._then);

  final CritereRgaaModel _value;
  // ignore: unused_field
  final $Res Function(CritereRgaaModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? number = freezed,
    Object? thematique = freezed,
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
              as String,
      thematique: thematique == freezed
          ? _value.thematique
          : thematique // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_CritereRgaaModelCopyWith<$Res>
    implements $CritereRgaaModelCopyWith<$Res> {
  factory _$$_CritereRgaaModelCopyWith(
          _$_CritereRgaaModel value, $Res Function(_$_CritereRgaaModel) then) =
      __$$_CritereRgaaModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id, String uuid, String name, String number, String thematique});
}

/// @nodoc
class __$$_CritereRgaaModelCopyWithImpl<$Res>
    extends _$CritereRgaaModelCopyWithImpl<$Res>
    implements _$$_CritereRgaaModelCopyWith<$Res> {
  __$$_CritereRgaaModelCopyWithImpl(
      _$_CritereRgaaModel _value, $Res Function(_$_CritereRgaaModel) _then)
      : super(_value, (v) => _then(v as _$_CritereRgaaModel));

  @override
  _$_CritereRgaaModel get _value => super._value as _$_CritereRgaaModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? number = freezed,
    Object? thematique = freezed,
  }) {
    return _then(_$_CritereRgaaModel(
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
              as String,
      thematique: thematique == freezed
          ? _value.thematique
          : thematique // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CritereRgaaModel implements _CritereRgaaModel {
  _$_CritereRgaaModel(
      {required this.id,
      required this.uuid,
      required this.name,
      required this.number,
      required this.thematique});

  factory _$_CritereRgaaModel.fromJson(Map<String, dynamic> json) =>
      _$$_CritereRgaaModelFromJson(json);

  @override
  final int id;
  @override
  final String uuid;
  @override
  final String name;
  @override
  final String number;
  @override
  final String thematique;

  @override
  String toString() {
    return 'CritereRgaaModel(id: $id, uuid: $uuid, name: $name, number: $number, thematique: $thematique)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CritereRgaaModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality()
                .equals(other.thematique, thematique));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(thematique));

  @JsonKey(ignore: true)
  @override
  _$$_CritereRgaaModelCopyWith<_$_CritereRgaaModel> get copyWith =>
      __$$_CritereRgaaModelCopyWithImpl<_$_CritereRgaaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CritereRgaaModelToJson(
      this,
    );
  }
}

abstract class _CritereRgaaModel implements CritereRgaaModel {
  factory _CritereRgaaModel(
      {required final int id,
      required final String uuid,
      required final String name,
      required final String number,
      required final String thematique}) = _$_CritereRgaaModel;

  factory _CritereRgaaModel.fromJson(Map<String, dynamic> json) =
      _$_CritereRgaaModel.fromJson;

  @override
  int get id;
  @override
  String get uuid;
  @override
  String get name;
  @override
  String get number;
  @override
  String get thematique;
  @override
  @JsonKey(ignore: true)
  _$$_CritereRgaaModelCopyWith<_$_CritereRgaaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
