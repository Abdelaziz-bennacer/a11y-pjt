// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get firstname => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get function => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  String? get avatarURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String uuid,
      String username,
      String name,
      String firstname,
      String email,
      String function,
      bool isAdmin,
      String? avatarURL});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? username = freezed,
    Object? name = freezed,
    Object? firstname = freezed,
    Object? email = freezed,
    Object? function = freezed,
    Object? isAdmin = freezed,
    Object? avatarURL = freezed,
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
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstname: firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      function: function == freezed
          ? _value.function
          : function // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: isAdmin == freezed
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      avatarURL: avatarURL == freezed
          ? _value.avatarURL
          : avatarURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String uuid,
      String username,
      String name,
      String firstname,
      String email,
      String function,
      bool isAdmin,
      String? avatarURL});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, (v) => _then(v as _$_UserModel));

  @override
  _$_UserModel get _value => super._value as _$_UserModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? uuid = freezed,
    Object? username = freezed,
    Object? name = freezed,
    Object? firstname = freezed,
    Object? email = freezed,
    Object? function = freezed,
    Object? isAdmin = freezed,
    Object? avatarURL = freezed,
  }) {
    return _then(_$_UserModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstname: firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      function: function == freezed
          ? _value.function
          : function // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: isAdmin == freezed
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      avatarURL: avatarURL == freezed
          ? _value.avatarURL
          : avatarURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  _$_UserModel(
      {required this.id,
      required this.uuid,
      required this.username,
      required this.name,
      required this.firstname,
      required this.email,
      required this.function,
      required this.isAdmin,
      this.avatarURL});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final int id;
  @override
  final String uuid;
  @override
  final String username;
  @override
  final String name;
  @override
  final String firstname;
  @override
  final String email;
  @override
  final String function;
  @override
  final bool isAdmin;
  @override
  final String? avatarURL;

  @override
  String toString() {
    return 'UserModel(id: $id, uuid: $uuid, username: $username, name: $name, firstname: $firstname, email: $email, function: $function, isAdmin: $isAdmin, avatarURL: $avatarURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.firstname, firstname) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.function, function) &&
            const DeepCollectionEquality().equals(other.isAdmin, isAdmin) &&
            const DeepCollectionEquality().equals(other.avatarURL, avatarURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(firstname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(function),
      const DeepCollectionEquality().hash(isAdmin),
      const DeepCollectionEquality().hash(avatarURL));

  @JsonKey(ignore: true)
  @override
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {required final int id,
      required final String uuid,
      required final String username,
      required final String name,
      required final String firstname,
      required final String email,
      required final String function,
      required final bool isAdmin,
      final String? avatarURL}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  int get id;
  @override
  String get uuid;
  @override
  String get username;
  @override
  String get name;
  @override
  String get firstname;
  @override
  String get email;
  @override
  String get function;
  @override
  bool get isAdmin;
  @override
  String? get avatarURL;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
