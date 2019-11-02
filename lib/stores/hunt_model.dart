import 'dart:async';
import 'dart:io';

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
  });

  final List<Hunt> objects;

  final DateTime timeLimit;

  // multi
  final bool isMultiplayer;

  final String gameId;

  final String userId;

  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();

  bool isTimeUp = false;

  bool isHuntComplete = false;

  final Stopwatch duration = Stopwatch();

  final repository = Repository.instance;

  //multiplayer

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

    if (isMultiplayer) {}
  }

  void init() {
    final limit =
        Duration(seconds: timeLimit.difference(DateTime.now()).inSeconds);
    duration.start();
    Timer(limit, () {
      isTimeUp = true;

      notifyListeners();
      duration.stop();
    });
  }

  void initMultiplayer() {
    //get playerstream listener
  }

  void disposeMultiplayer() {
    //dispose stream
    //change status to done
  }

  void _scanImage(File image) async {
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

    scanResults.forEach((results) {
      objects.where((hunt) => !hunt.isFound).forEach((words) {
        if (results.text.toLowerCase() == words.word.toLowerCase()) {
          count++;
          words.isFound = true;
        }
      });
    });

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
