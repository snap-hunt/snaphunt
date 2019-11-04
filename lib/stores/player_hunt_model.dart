import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/player.dart';

class PlayHuntModel with ChangeNotifier {
  final String gameId;

  final List<Player> players;

  PlayHuntModel({this.players, this.gameId});

  StreamSubscription<QuerySnapshot> playerStream;

  final repository = Repository.instance;

  @override
  void addListener(listener) {
    super.addListener(listener);
    initStreams();
  }

  @override
  void dispose() {
    playerStream.cancel();
    super.dispose();
  }

  void initStreams() {
    playerStream = repository.playersSnapshot(gameId).listen(playerListener);
  }

  void playerListener(QuerySnapshot snapshot) {
    snapshot.documentChanges.forEach((DocumentChange change) async {
      print(change.type);
      print(change.document.documentID);

      // if (DocumentChangeType.added == change.type) {
      //   players.add(
      //       Player(user: await repository.getUser(change.document.documentID)));
      // } else if (DocumentChangeType.removed == change.type) {}

      // notifyListeners();
    });
  }
}
