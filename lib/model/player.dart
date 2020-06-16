import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snaphunt/model/user.dart';
import 'package:flutter/foundation.dart';

part 'player.g.dart';
part 'player.freezed.dart';

@freezed
abstract class Player with _$Player {
  const factory Player({
    User user,
    @Default(0) int score,
    @Default('active') String status,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
