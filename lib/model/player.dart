import 'package:snaphunt/model/user.dart';

class Player {
  User user;
  int score;
  String status;

  Player({this.user, this.score = 0, this.status = 'active'});

  Player.fromJson(Map<String, dynamic> json, Map<String, dynamic> userJson) {
    user = User.fromJson(userJson);
    score = json['score'] as int;
    status = json['status'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['score'] = score;
    data['status'] = status;
    return data;
  }
}
