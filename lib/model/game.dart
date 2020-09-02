import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.g.dart';
part 'game.freezed.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    String id,
    String name,
    String createdBy,
    String hostName,
    int maxPlayers,
    int timeLimit,
    int noOfItems,
    String status,
    @TimestampConverter() DateTime timeCreated,
    @TimestampConverter() DateTime gameStartTime,
    List<String> words,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  factory Game.fromFirestore(DocumentSnapshot doc) =>
      Game.fromJson(doc.data()).copyWith(id: doc.id);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp value) => value?.toDate();

  @override
  Timestamp toJson(DateTime value) =>
      value != null ? Timestamp.fromDate(value) : null;
}
