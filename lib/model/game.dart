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
      Game.fromJson(doc.data).copyWith(id: doc.documentID);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp value) => value?.toDate();

  @override
  Timestamp toJson(DateTime value) =>
      value != null ? Timestamp.fromDate(value) : null;
}

// class Game {
//   String id;
//   String name;
//   String createdBy;
//   int maxPlayers;
//   int timeLimit;
//   int noOfItems;
//   String status;
//   DateTime timeCreated;
//   DateTime gameStartTime;
//   List<String> words;

//   Game(
//       {this.id,
//       this.name,
//       this.createdBy,
//       this.maxPlayers,
//       this.timeLimit,
//       this.noOfItems,
//       this.status,
//       this.timeCreated,
//       this.gameStartTime,
//       this.words});

//   Game.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as String;
//     name = json['name'] as String;
//     createdBy = json['createdBy'] as String;
//     maxPlayers = json['maxPlayers'] as int;
//     timeLimit = json['timeLimit'] as int;
//     noOfItems = json['noOfItems'] as int;
//     status = json['status'] as String;
//     timeCreated = DateTime.fromMillisecondsSinceEpoch(
//         (json['timeCreated'] as Timestamp).millisecondsSinceEpoch);
//     gameStartTime = json['gameStartTime'] != null
//         ? DateTime.fromMillisecondsSinceEpoch(
//             (json['gameStartTime'] as Timestamp).millisecondsSinceEpoch)
//         : null;
//     words = json['words']?.cast<String>() as List<String>;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['createdBy'] = createdBy;
//     data['maxPlayers'] = maxPlayers;
//     data['timeLimit'] = timeLimit;
//     data['noOfItems'] = noOfItems;
//     data['status'] = status;
//     data['timeCreated'] = timeCreated;
//     data['gameStartTime'] = gameStartTime;
//     data['words'] = words;
//     return data;
//   }
// }
