import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/model/user.dart' as user;
import 'package:snaphunt/utils/utils.dart';

class Repository {
  static final Repository _singleton = Repository._();

  factory Repository() => _singleton;

  Repository._();

  static Repository get instance => _singleton;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateUserData(User user) async {
    final DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set(<String, dynamic>{
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
    }, SetOptions(merge: true));
  }

  Future<String> createRoom(Game game) async {
    final DocumentReference ref =
        await _db.collection('games').add(game.toJson());
    return ref.id;
  }

  Future<Game> retrieveGame(String roomId) async {
    Game game;

    try {
      final DocumentSnapshot ref = await _db.doc('games/$roomId').get();

      if (ref.data != null) {
        // game = Game.fromJson(ref.data)..id = ref.docID;
        game = Game.fromFirestore(ref);
      }
    } catch (e) {
      print(e);
    }

    return game;
  }

  Future joinRoom(String roomId, String userId) async {
    return _db
        .doc('games/$roomId')
        .collection('players')
        .doc(userId)
        .set({'status': 'active', 'score': 0});
  }

  Future<void> cancelRoom(String roomId) async {
    await _db.doc('games/$roomId').update({'status': 'cancelled'});
  }

  Future<void> leaveRoom(String roomId, String userId) async {
    await _db.doc('games/$roomId').collection('players').doc(userId).delete();
  }

  Future<void> endGame(String roomId) async {
    await _db.doc('games/$roomId').update({'status': 'end'});
  }

  Future<void> startGame(String roomId, {int numOfItems = 8}) async {
    await _db.doc('games/$roomId').update({
      'status': 'in_game',
      'gameStartTime': Timestamp.now(),
      'words': generateWords(numOfItems)
    });
  }

  Future<String> getUserName(String uuid) async {
    final DocumentSnapshot ref = await _db.collection('users').doc(uuid).get();
    return ref.data()['displayName'] as String;
  }

  Future<user.User> getUser(String uuid) async {
    final DocumentSnapshot ref = await _db.collection('users').doc(uuid).get();
    return user.User.fromJson(ref.data());
  }

  Stream<DocumentSnapshot> gameSnapshot(String roomId) {
    return _db.collection('games').doc(roomId).snapshots();
  }

  Stream<QuerySnapshot> playersSnapshot(String gameId) {
    return _db
        .collection('games')
        .doc(gameId)
        .collection('players')
        .snapshots();
  }

  Future<void> kickPlayer(String gameId, String userId) async {
    await _db
        .collection('games')
        .doc(gameId)
        .collection('players')
        .doc(userId)
        .delete();
  }

  Future<int> getGamePlayerCount(String gameId) async {
    final players =
        await _db.collection('games').doc(gameId).collection('players').get();
    return players.docs.length;
  }

  Future<void> updateLocalWords() async {
    final box = Hive.box('words');

    final DocumentSnapshot doc = await _db.doc('words/words').get();

    final localVersion = box.get('version');
    final onlineVersion = doc.data()['version'];

    if (localVersion != onlineVersion) {
      box.put('words', doc.data()['words']);
      box.put('version', doc.data()['version']);
    }
  }

  Future updateUserScore(String gameId, String userId, int increment) async {
    final DocumentReference ref = _db.doc('games/$gameId/players/$userId');
    return ref.set({
      'score': FieldValue.increment(increment),
    }, SetOptions(merge: true));
  }

  Future<List<Player>> getPlayers(String gameId) async {
    final List<Player> players = [];
    final QuerySnapshot ref =
        await _db.collection('games').doc(gameId).collection('players').get();

    for (final document in ref.docs) {
      final DocumentSnapshot userRef =
          await _db.collection('users').doc(document.id).get();
      document.data()["user"] = userRef.data;
      players.add(Player.fromJson(document.data()));
    }

    return players;
  }
}
