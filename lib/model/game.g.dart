// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$_$_GameFromJson(Map<String, dynamic> json) {
  return _$_Game(
    id: json['id'] as String,
    name: json['name'] as String,
    createdBy: json['createdBy'] as String,
    hostName: json['hostName'] as String,
    maxPlayers: json['maxPlayers'] as int,
    timeLimit: json['timeLimit'] as int,
    noOfItems: json['noOfItems'] as int,
    status: json['status'] as String,
    timeCreated:
        const TimestampConverter().fromJson(json['timeCreated'] as Timestamp),
    gameStartTime:
        const TimestampConverter().fromJson(json['gameStartTime'] as Timestamp),
    words: (json['words'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$_$_GameToJson(_$_Game instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'hostName': instance.hostName,
      'maxPlayers': instance.maxPlayers,
      'timeLimit': instance.timeLimit,
      'noOfItems': instance.noOfItems,
      'status': instance.status,
      'timeCreated': const TimestampConverter().toJson(instance.timeCreated),
      'gameStartTime':
          const TimestampConverter().toJson(instance.gameStartTime),
      'words': instance.words,
    };
