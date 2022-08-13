// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'team_board_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TeamBoardList _$TeamBoardListFromJson(Map<String, dynamic> json) {
  return _TeamBoardList.fromJson(json);
}

/// @nodoc
mixin _$TeamBoardList {
//required Widget header,
  String get title => throw _privateConstructorUsedError;
  List<TeamBoardItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamBoardListCopyWith<TeamBoardList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamBoardListCopyWith<$Res> {
  factory $TeamBoardListCopyWith(
          TeamBoardList value, $Res Function(TeamBoardList) then) =
      _$TeamBoardListCopyWithImpl<$Res>;
  $Res call({String title, List<TeamBoardItem> items});
}

/// @nodoc
class _$TeamBoardListCopyWithImpl<$Res>
    implements $TeamBoardListCopyWith<$Res> {
  _$TeamBoardListCopyWithImpl(this._value, this._then);

  final TeamBoardList _value;
  // ignore: unused_field
  final $Res Function(TeamBoardList) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TeamBoardItem>,
    ));
  }
}

/// @nodoc
abstract class _$$_TeamBoardListCopyWith<$Res>
    implements $TeamBoardListCopyWith<$Res> {
  factory _$$_TeamBoardListCopyWith(
          _$_TeamBoardList value, $Res Function(_$_TeamBoardList) then) =
      __$$_TeamBoardListCopyWithImpl<$Res>;
  @override
  $Res call({String title, List<TeamBoardItem> items});
}

/// @nodoc
class __$$_TeamBoardListCopyWithImpl<$Res>
    extends _$TeamBoardListCopyWithImpl<$Res>
    implements _$$_TeamBoardListCopyWith<$Res> {
  __$$_TeamBoardListCopyWithImpl(
      _$_TeamBoardList _value, $Res Function(_$_TeamBoardList) _then)
      : super(_value, (v) => _then(v as _$_TeamBoardList));

  @override
  _$_TeamBoardList get _value => super._value as _$_TeamBoardList;

  @override
  $Res call({
    Object? title = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_TeamBoardList(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      items: items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TeamBoardItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TeamBoardList implements _TeamBoardList {
  _$_TeamBoardList(
      {required this.title, required final List<TeamBoardItem> items})
      : _items = items;

  factory _$_TeamBoardList.fromJson(Map<String, dynamic> json) =>
      _$$_TeamBoardListFromJson(json);

//required Widget header,
  @override
  final String title;
  final List<TeamBoardItem> _items;
  @override
  List<TeamBoardItem> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'TeamBoardList(title: $title, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamBoardList &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  _$$_TeamBoardListCopyWith<_$_TeamBoardList> get copyWith =>
      __$$_TeamBoardListCopyWithImpl<_$_TeamBoardList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeamBoardListToJson(
      this,
    );
  }
}

abstract class _TeamBoardList implements TeamBoardList {
  factory _TeamBoardList(
      {required final String title,
      required final List<TeamBoardItem> items}) = _$_TeamBoardList;

  factory _TeamBoardList.fromJson(Map<String, dynamic> json) =
      _$_TeamBoardList.fromJson;

  @override //required Widget header,
  String get title;
  @override
  List<TeamBoardItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$_TeamBoardListCopyWith<_$_TeamBoardList> get copyWith =>
      throw _privateConstructorUsedError;
}
