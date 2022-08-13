// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'team_board_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TeamBoardItem _$TeamBoardItemFromJson(Map<String, dynamic> json) {
  return _TeamBoardItem.fromJson(json);
}

/// @nodoc
mixin _$TeamBoardItem {
  String get title => throw _privateConstructorUsedError;
  String get urlImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamBoardItemCopyWith<TeamBoardItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamBoardItemCopyWith<$Res> {
  factory $TeamBoardItemCopyWith(
          TeamBoardItem value, $Res Function(TeamBoardItem) then) =
      _$TeamBoardItemCopyWithImpl<$Res>;
  $Res call({String title, String urlImage});
}

/// @nodoc
class _$TeamBoardItemCopyWithImpl<$Res>
    implements $TeamBoardItemCopyWith<$Res> {
  _$TeamBoardItemCopyWithImpl(this._value, this._then);

  final TeamBoardItem _value;
  // ignore: unused_field
  final $Res Function(TeamBoardItem) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? urlImage = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      urlImage: urlImage == freezed
          ? _value.urlImage
          : urlImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TeamBoardItemCopyWith<$Res>
    implements $TeamBoardItemCopyWith<$Res> {
  factory _$$_TeamBoardItemCopyWith(
          _$_TeamBoardItem value, $Res Function(_$_TeamBoardItem) then) =
      __$$_TeamBoardItemCopyWithImpl<$Res>;
  @override
  $Res call({String title, String urlImage});
}

/// @nodoc
class __$$_TeamBoardItemCopyWithImpl<$Res>
    extends _$TeamBoardItemCopyWithImpl<$Res>
    implements _$$_TeamBoardItemCopyWith<$Res> {
  __$$_TeamBoardItemCopyWithImpl(
      _$_TeamBoardItem _value, $Res Function(_$_TeamBoardItem) _then)
      : super(_value, (v) => _then(v as _$_TeamBoardItem));

  @override
  _$_TeamBoardItem get _value => super._value as _$_TeamBoardItem;

  @override
  $Res call({
    Object? title = freezed,
    Object? urlImage = freezed,
  }) {
    return _then(_$_TeamBoardItem(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      urlImage: urlImage == freezed
          ? _value.urlImage
          : urlImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TeamBoardItem implements _TeamBoardItem {
  _$_TeamBoardItem({required this.title, required this.urlImage});

  factory _$_TeamBoardItem.fromJson(Map<String, dynamic> json) =>
      _$$_TeamBoardItemFromJson(json);

  @override
  final String title;
  @override
  final String urlImage;

  @override
  String toString() {
    return 'TeamBoardItem(title: $title, urlImage: $urlImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamBoardItem &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.urlImage, urlImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(urlImage));

  @JsonKey(ignore: true)
  @override
  _$$_TeamBoardItemCopyWith<_$_TeamBoardItem> get copyWith =>
      __$$_TeamBoardItemCopyWithImpl<_$_TeamBoardItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeamBoardItemToJson(
      this,
    );
  }
}

abstract class _TeamBoardItem implements TeamBoardItem {
  factory _TeamBoardItem(
      {required final String title,
      required final String urlImage}) = _$_TeamBoardItem;

  factory _TeamBoardItem.fromJson(Map<String, dynamic> json) =
      _$_TeamBoardItem.fromJson;

  @override
  String get title;
  @override
  String get urlImage;
  @override
  @JsonKey(ignore: true)
  _$$_TeamBoardItemCopyWith<_$_TeamBoardItem> get copyWith =>
      throw _privateConstructorUsedError;
}
