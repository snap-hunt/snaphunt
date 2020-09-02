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

  final Repository repository = Repository.instance;

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
    for (final change in snapshot.docChanges) {
      if (DocumentChangeType.modified == change.type) {
        final int index =
            players.indexWhere((player) => player.user.uid == change.doc.id);

        if (index != -1) {
          // players[index].score = change.document.data['score'] as int;
          players.replaceRange(index, index + 1, [
            players[index].copyWith(score: change.doc.data()['score'] as int),
          ]);
          sort();
          notifyListeners();
        }
      }
    }
  }

  void sort() {
    players.sort((a, b) => b.score.compareTo(a.score));
  }
}
