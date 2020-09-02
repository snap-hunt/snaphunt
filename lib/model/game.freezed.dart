// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

class _$GameTearOff {
  const _$GameTearOff();

  _Game call(
      {String id,
      String name,
      String createdBy,
      String hostName,
      int maxPlayers,
      int timeLimit,
      int noOfItems,
      String status,
      @TimestampConverter() DateTime timeCreated,
      @TimestampConverter() DateTime gameStartTime,
      List<String> words}) {
    return _Game(
      id: id,
      name: name,
      createdBy: createdBy,
      hostName: hostName,
      maxPlayers: maxPlayers,
      timeLimit: timeLimit,
      noOfItems: noOfItems,
      status: status,
      timeCreated: timeCreated,
      gameStartTime: gameStartTime,
      words: words,
    );
  }
}

// ignore: unused_element
const $Game = _$GameTearOff();

mixin _$Game {
  String get id;
  String get name;
  String get createdBy;
  String get hostName;
  int get maxPlayers;
  int get timeLimit;
  int get noOfItems;
  String get status;
  @TimestampConverter()
  DateTime get timeCreated;
  @TimestampConverter()
  DateTime get gameStartTime;
  List<String> get words;

  Map<String, dynamic> toJson();
  $GameCopyWith<Game> get copyWith;
}

abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String createdBy,
      String hostName,
      int maxPlayers,
      int timeLimit,
      int noOfItems,
      String status,
      @TimestampConverter() DateTime timeCreated,
      @TimestampConverter() DateTime gameStartTime,
      List<String> words});
}

class _$GameCopyWithImpl<$Res> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  final Game _value;
  // ignore: unused_field
  final $Res Function(Game) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object createdBy = freezed,
    Object hostName = freezed,
    Object maxPlayers = freezed,
    Object timeLimit = freezed,
    Object noOfItems = freezed,
    Object status = freezed,
    Object timeCreated = freezed,
    Object gameStartTime = freezed,
    Object words = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      createdBy: createdBy == freezed ? _value.createdBy : createdBy as String,
      hostName: hostName == freezed ? _value.hostName : hostName as String,
      maxPlayers: maxPlayers == freezed ? _value.maxPlayers : maxPlayers as int,
      timeLimit: timeLimit == freezed ? _value.timeLimit : timeLimit as int,
      noOfItems: noOfItems == freezed ? _value.noOfItems : noOfItems as int,
      status: status == freezed ? _value.status : status as String,
      timeCreated:
          timeCreated == freezed ? _value.timeCreated : timeCreated as DateTime,
      gameStartTime: gameStartTime == freezed
          ? _value.gameStartTime
          : gameStartTime as DateTime,
      words: words == freezed ? _value.words : words as List<String>,
    ));
  }
}

abstract class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) then) =
      __$GameCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String createdBy,
      String hostName,
      int maxPlayers,
      int timeLimit,
      int noOfItems,
      String status,
      @TimestampConverter() DateTime timeCreated,
      @TimestampConverter() DateTime gameStartTime,
      List<String> words});
}

class __$GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(_Game _value, $Res Function(_Game) _then)
      : super(_value, (v) => _then(v as _Game));

  @override
  _Game get _value => super._value as _Game;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object createdBy = freezed,
    Object hostName = freezed,
    Object maxPlayers = freezed,
    Object timeLimit = freezed,
    Object noOfItems = freezed,
    Object status = freezed,
    Object timeCreated = freezed,
    Object gameStartTime = freezed,
    Object words = freezed,
  }) {
    return _then(_Game(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      createdBy: createdBy == freezed ? _value.createdBy : createdBy as String,
      hostName: hostName == freezed ? _value.hostName : hostName as String,
      maxPlayers: maxPlayers == freezed ? _value.maxPlayers : maxPlayers as int,
      timeLimit: timeLimit == freezed ? _value.timeLimit : timeLimit as int,
      noOfItems: noOfItems == freezed ? _value.noOfItems : noOfItems as int,
      status: status == freezed ? _value.status : status as String,
      timeCreated:
          timeCreated == freezed ? _value.timeCreated : timeCreated as DateTime,
      gameStartTime: gameStartTime == freezed
          ? _value.gameStartTime
          : gameStartTime as DateTime,
      words: words == freezed ? _value.words : words as List<String>,
    ));
  }
}

@JsonSerializable()
class _$_Game implements _Game {
  const _$_Game(
      {this.id,
      this.name,
      this.createdBy,
      this.hostName,
      this.maxPlayers,
      this.timeLimit,
      this.noOfItems,
      this.status,
      @TimestampConverter() this.timeCreated,
      @TimestampConverter() this.gameStartTime,
      this.words});

  factory _$_Game.fromJson(Map<String, dynamic> json) =>
      _$_$_GameFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String createdBy;
  @override
  final String hostName;
  @override
  final int maxPlayers;
  @override
  final int timeLimit;
  @override
  final int noOfItems;
  @override
  final String status;
  @override
  @TimestampConverter()
  final DateTime timeCreated;
  @override
  @TimestampConverter()
  final DateTime gameStartTime;
  @override
  final List<String> words;

  @override
  String toString() {
    return 'Game(id: $id, name: $name, createdBy: $createdBy, hostName: $hostName, maxPlayers: $maxPlayers, timeLimit: $timeLimit, noOfItems: $noOfItems, status: $status, timeCreated: $timeCreated, gameStartTime: $gameStartTime, words: $words)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Game &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality()
                    .equals(other.createdBy, createdBy)) &&
            (identical(other.hostName, hostName) ||
                const DeepCollectionEquality()
                    .equals(other.hostName, hostName)) &&
            (identical(other.maxPlayers, maxPlayers) ||
                const DeepCollectionEquality()
                    .equals(other.maxPlayers, maxPlayers)) &&
            (identical(other.timeLimit, timeLimit) ||
                const DeepCollectionEquality()
                    .equals(other.timeLimit, timeLimit)) &&
            (identical(other.noOfItems, noOfItems) ||
                const DeepCollectionEquality()
                    .equals(other.noOfItems, noOfItems)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.timeCreated, timeCreated) ||
                const DeepCollectionEquality()
                    .equals(other.timeCreated, timeCreated)) &&
            (identical(other.gameStartTime, gameStartTime) ||
                const DeepCollectionEquality()
                    .equals(other.gameStartTime, gameStartTime)) &&
            (identical(other.words, words) ||
                const DeepCollectionEquality().equals(other.words, words)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(hostName) ^
      const DeepCollectionEquality().hash(maxPlayers) ^
      const DeepCollectionEquality().hash(timeLimit) ^
      const DeepCollectionEquality().hash(noOfItems) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(timeCreated) ^
      const DeepCollectionEquality().hash(gameStartTime) ^
      const DeepCollectionEquality().hash(words);

  @override
  _$GameCopyWith<_Game> get copyWith =>
      __$GameCopyWithImpl<_Game>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GameToJson(this);
  }
}

abstract class _Game implements Game {
  const factory _Game(
      {String id,
      String name,
      String createdBy,
      String hostName,
      int maxPlayers,
      int timeLimit,
      int noOfItems,
      String status,
      @TimestampConverter() DateTime timeCreated,
      @TimestampConverter() DateTime gameStartTime,
      List<String> words}) = _$_Game;

  factory _Game.fromJson(Map<String, dynamic> json) = _$_Game.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get createdBy;
  @override
  String get hostName;
  @override
  int get maxPlayers;
  @override
  int get timeLimit;
  @override
  int get noOfItems;
  @override
  String get status;
  @override
  @TimestampConverter()
  DateTime get timeCreated;
  @override
  @TimestampConverter()
  DateTime get gameStartTime;
  @override
  List<String> get words;
  @override
  _$GameCopyWith<_Game> get copyWith;
}
