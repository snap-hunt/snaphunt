import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snaphunt/model/game.dart';

class Repository {
  static final Repository _singleton = Repository._();

  Repository._();

  factory Repository() => _singleton;

  static Repository get instance => _singleton;

  final Firestore _db = Firestore.instance;

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future<String> createRoom(Game game) async {
    DocumentReference ref = await _db.collection('games').add(game.toJson());
    return ref.documentID;
  }

  Future<Game> joinGame(String roomId) {
    return null;
  }

  void joinRoom(String roomId, String userId) async {
    await _db
        .document('games/$roomId')
        .collection('players')
        .document(userId)
        .setData({'status': 'active', 'score': 0});
  }

  void cancelRoom(String roomId) async {
    await _db.document('games/$roomId').updateData({'status': 'cancelled'});
  }

  void leaveRoom(String roomId, String userId) async {
    await _db
        .document('games/$roomId')
        .collection('players')
        .document('userId')
        .delete();
  }

  Future<String> getUserName(String uuid) async {
    DocumentSnapshot ref = await _db.collection('users').document(uuid).get();
    return ref['displayName'];
  }
}
