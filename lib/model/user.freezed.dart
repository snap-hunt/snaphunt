// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {String uid,
      String email,
      @JsonKey(name: 'photoURL') String photoUrl,
      String displayName}) {
    return _User(
      uid: uid,
      email: email,
      photoUrl: photoUrl,
      displayName: displayName,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  String get uid;
  String get email;
  @JsonKey(name: 'photoURL')
  String get photoUrl;
  String get displayName;

  Map<String, dynamic> toJson();
  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String email,
      @JsonKey(name: 'photoURL') String photoUrl,
      String displayName});
}

class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object email = freezed,
    Object photoUrl = freezed,
    Object displayName = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as String,
      email: email == freezed ? _value.email : email as String,
      photoUrl: photoUrl == freezed ? _value.photoUrl : photoUrl as String,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
    ));
  }
}

abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String email,
      @JsonKey(name: 'photoURL') String photoUrl,
      String displayName});
}

class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object uid = freezed,
    Object email = freezed,
    Object photoUrl = freezed,
    Object displayName = freezed,
  }) {
    return _then(_User(
      uid: uid == freezed ? _value.uid : uid as String,
      email: email == freezed ? _value.email : email as String,
      photoUrl: photoUrl == freezed ? _value.photoUrl : photoUrl as String,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
    ));
  }
}

@JsonSerializable()
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {this.uid,
      this.email,
      @JsonKey(name: 'photoURL') this.photoUrl,
      this.displayName});

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  @JsonKey(name: 'photoURL')
  final String photoUrl;
  @override
  final String displayName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(uid: $uid, email: $email, photoUrl: $photoUrl, displayName: $displayName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('photoUrl', photoUrl))
      ..add(DiagnosticsProperty('displayName', displayName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.photoUrl, photoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.photoUrl, photoUrl)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(photoUrl) ^
      const DeepCollectionEquality().hash(displayName);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  const factory _User(
      {String uid,
      String email,
      @JsonKey(name: 'photoURL') String photoUrl,
      String displayName}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  @JsonKey(name: 'photoURL')
  String get photoUrl;
  @override
  String get displayName;
  @override
  _$UserCopyWith<_User> get copyWith;
}
