import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:vibration/vibration.dart';

class HuntModel with ChangeNotifier {
  HuntModel({
    this.objects,
    this.timeLimit,
    this.isMultiplayer = false,
    this.gameId,
    this.userId,
    this.timeDuration,
  });

  final List<Hunt> objects;

  int get objectsFound => objects.where((hunt) => hunt.isFound).length;

  Hunt get nextNotFound {
    Hunt hunt;

    try {
      hunt = objects.where((hunt) => !hunt.isFound).first;
    } catch (e) {
      hunt = null;
    }
    return hunt;
  }

  final DateTime timeLimit;

  // multi
  final bool isMultiplayer;

  final String gameId;

  final String userId;

  final int timeDuration;

  bool isGameEnd = false;

  StreamSubscription<DocumentSnapshot> gameStream;

  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler(
    const ImageLabelerOptions(
      confidenceThreshold: 0.65,
    ),
  );

  bool isTimeUp = false;

  bool isHuntComplete = false;

  final Stopwatch duration = Stopwatch();

  final Repository repository = Repository.instance;

  Timer timer;

  @override
  void addListener(listener) {
    super.addListener(listener);
    init();

    if (isMultiplayer) {
      initMultiplayer();
    }
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();

    if (isMultiplayer) {
      disposeMultiplayer();
    }
  }

  void init() {
    final limit =
        Duration(seconds: timeLimit.difference(DateTime.now()).inSeconds);
    duration.start();
    timer = Timer(limit, () {
      isTimeUp = true;

      if (isMultiplayer) {
        repository.endGame(gameId);
      }
      notifyListeners();
      duration.stop();
    });
  }

  void initMultiplayer() {
    gameStream = repository.gameSnapshot(gameId).listen(gameStatusListener);
  }

  void disposeMultiplayer() {
    gameStream.cancel();
  }

  Future<void> gameStatusListener(DocumentSnapshot snapshot) async {
    final status = snapshot.data()['status'];
    if (status == 'end') {
      isGameEnd = true;
      notifyListeners();
    }
  }

  Future<void> _scanImage(File image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final results = await _imageLabeler.processImage(visionImage);

    checkWords(results);
  }

  void checkWords(List<ImageLabel> scanResults) {
    hasMatch(scanResults).then((result) {
      if (result != 0) {
        successVibrate();
        incrementScore(result);

        checkComplete().then((complete) {
          if (complete) {
            isHuntComplete = true;

            if (isMultiplayer) {
              repository.endGame(gameId);
            }
          }
        });
      } else {
        failVibrate();
      }
    });
    notifyListeners();
  }

  Future<int> hasMatch(List<ImageLabel> scanResults) async {
    int count = 0;

    for (final results in scanResults) {
      objects.where((hunt) => !hunt.isFound).forEach((words) {
        if (results.text.toLowerCase() == words.word.toLowerCase()) {
          count++;
          // words.isFound = true;

          final int index = objects.indexOf(words);
          objects.replaceRange(index, index + 1, [
            words.copyWith(isFound: true),
          ]);
        }
      });
    }

    return count;
  }

  void incrementScore(int increment) {
    if (isMultiplayer && increment != 0) {
      repository.updateUserScore(gameId, userId, increment);
    }
  }

  Future<bool> checkComplete() async {
    bool isComplete = false;

    if (objects.where((hunt) => !hunt.isFound).isEmpty) {
      isComplete = true;
    }

    return isComplete;
  }

  void onCameraPressed(String path) {
    _scanImage(File(path));
  }

  void successVibrate() {
    Vibration.vibrate(pattern: [0, 250, 250, 250]);
  }

  void failVibrate() {
    Vibration.vibrate(pattern: [0, 250]);
  }
}
