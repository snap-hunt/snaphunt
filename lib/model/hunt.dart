import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'hunt.freezed.dart';
part 'hunt.g.dart';

@freezed
abstract class Hunt with _$Hunt {
  const factory Hunt({
    String word,
    @Default(false) bool isFound,
  }) = _Hunt;

  factory Hunt.fromJson(Map<String, dynamic> json) => _$HuntFromJson(json);
}
