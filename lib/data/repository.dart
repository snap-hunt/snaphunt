import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/model/user.dart';

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
    Game game;

    try {
      final DocumentSnapshot ref = await _db.document('games/$roomId').get();

      if (ref.data != null) {
        game = Game.fromJson(ref.data)..id = ref.documentID;
      }
    } catch (e) {}

    return game;
  }

  Future joinRoom(String roomId, String userId) async {
    return _db
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

  void startGame(String roomId) async {
    await _db.document('games/$roomId').updateData({'status': 'in_game'});
  }

  Future<String> getUserName(String uuid) async {
    final DocumentSnapshot ref =
        await _db.collection('users').document(uuid).get();
    return ref['displayName'];
  }

  Future<User> getUser(String uuid) async {
    final DocumentSnapshot ref =
        await _db.collection('users').document(uuid).get();
    return User.fromJson(ref.data);
  }

  Stream<DocumentSnapshot> gameSnapshot(String gameId) {
    return _db.collection('games').document(gameId).snapshots();
  }

  Stream<QuerySnapshot> playersSnapshot(String gameId) {
    return _db
        .collection('games')
        .document(gameId)
        .collection('players')
        .snapshots();
  }

  void kickPlayer(String gameId, String userId) async {
    await _db
        .collection('games')
        .document(gameId)
        .collection('players')
        .document(userId)
        .delete();
  }

  Future<int> getGamePlayerCount(String gameId) async {
    final players = await _db
        .collection('games')
        .document(gameId)
        .collection('players')
        .getDocuments();
    return players.documents.length;
  }

  void updateLocalWords() async {
    final box = Hive.box('words');

    final DocumentSnapshot doc = await _db.document('words/words').get();

    final localVersion = box.get('version');
    final onlineVersion = doc.data['version'];

    if (localVersion != onlineVersion) {
      box.put('words', doc.data['words']);
      box.put('version', doc.data['version']);
    }
  }
}
