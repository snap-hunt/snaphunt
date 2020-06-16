// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

class _$PlayerTearOff {
  const _$PlayerTearOff();

  _Player call({User user, int score = 0, String status = 'active'}) {
    return _Player(
      user: user,
      score: score,
      status: status,
    );
  }
}

// ignore: unused_element
const $Player = _$PlayerTearOff();

mixin _$Player {
  User get user;
  int get score;
  String get status;

  Map<String, dynamic> toJson();
  $PlayerCopyWith<Player> get copyWith;
}

abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res>;
  $Res call({User user, int score, String status});

  $UserCopyWith<$Res> get user;
}

class _$PlayerCopyWithImpl<$Res> implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  final Player _value;
  // ignore: unused_field
  final $Res Function(Player) _then;

  @override
  $Res call({
    Object user = freezed,
    Object score = freezed,
    Object status = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed ? _value.user : user as User,
      score: score == freezed ? _value.score : score as int,
      status: status == freezed ? _value.status : status as String,
    ));
  }

  @override
  $UserCopyWith<$Res> get user {
    if (_value.user == null) {
      return null;
    }
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

abstract class _$PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$PlayerCopyWith(_Player value, $Res Function(_Player) then) =
      __$PlayerCopyWithImpl<$Res>;
  @override
  $Res call({User user, int score, String status});

  @override
  $UserCopyWith<$Res> get user;
}

class __$PlayerCopyWithImpl<$Res> extends _$PlayerCopyWithImpl<$Res>
    implements _$PlayerCopyWith<$Res> {
  __$PlayerCopyWithImpl(_Player _value, $Res Function(_Player) _then)
      : super(_value, (v) => _then(v as _Player));

  @override
  _Player get _value => super._value as _Player;

  @override
  $Res call({
    Object user = freezed,
    Object score = freezed,
    Object status = freezed,
  }) {
    return _then(_Player(
      user: user == freezed ? _value.user : user as User,
      score: score == freezed ? _value.score : score as int,
      status: status == freezed ? _value.status : status as String,
    ));
  }
}

@JsonSerializable()
class _$_Player with DiagnosticableTreeMixin implements _Player {
  const _$_Player({this.user, this.score = 0, this.status = 'active'})
      : assert(score != null),
        assert(status != null);

  factory _$_Player.fromJson(Map<String, dynamic> json) =>
      _$_$_PlayerFromJson(json);

  @override
  final User user;
  @JsonKey(defaultValue: 0)
  @override
  final int score;
  @JsonKey(defaultValue: 'active')
  @override
  final String status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Player(user: $user, score: $score, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Player'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Player &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.score, score) ||
                const DeepCollectionEquality().equals(other.score, score)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(score) ^
      const DeepCollectionEquality().hash(status);

  @override
  _$PlayerCopyWith<_Player> get copyWith =>
      __$PlayerCopyWithImpl<_Player>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PlayerToJson(this);
  }
}

abstract class _Player implements Player {
  const factory _Player({User user, int score, String status}) = _$_Player;

  factory _Player.fromJson(Map<String, dynamic> json) = _$_Player.fromJson;

  @override
  User get user;
  @override
  int get score;
  @override
  String get status;
  @override
  _$PlayerCopyWith<_Player> get copyWith;
}
