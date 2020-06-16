// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$_$_PlayerFromJson(Map<String, dynamic> json) {
  return _$_Player(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    score: json['score'] as int ?? 0,
    status: json['status'] as String ?? 'active',
  );
}

Map<String, dynamic> _$_$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'user': instance.user,
      'score': instance.score,
      'status': instance.status,
    };
