// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    uid: json['uid'] as String,
    email: json['email'] as String,
    photoUrl: json['photoURL'] as String,
    displayName: json['displayName'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'photoURL': instance.photoUrl,
      'displayName': instance.displayName,
    };
