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
    final DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future<String> createRoom(Game game) async {
    final DocumentReference ref =
        await _db.collection('games').add(game.toJson());
    return ref.documentID;
  }

  Future<Game> retrieveGame(String roomId) async {
    final DocumentSnapshot ref = await _db.document('games/$roomId').get();

    if (ref.data != null) {
      return Game.fromJson(ref.data)..id = ref.documentID;
    }

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
        .document(userId)
        .delete();
  }

  Future<String> getUserName(String uuid) async {
    final DocumentSnapshot ref =
        await _db.collection('users').document(uuid).get();
    return ref['displayName'];
  }
}
