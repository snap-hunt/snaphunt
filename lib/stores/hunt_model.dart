import 'dart:async';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:vibration/vibration.dart';

class HuntModel with ChangeNotifier {
  HuntModel({this.objects, this.timeLimit});

  final List<Hunt> objects;

  final DateTime timeLimit;

  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();

  bool isTimeUp = false;

  bool isHuntComplete = false;

  @override
  void addListener(listener) {
    super.addListener(listener);
    init();
  }

  void init() {
    final now = DateTime.now();
    final limit = Duration(seconds: timeLimit.difference(now).inSeconds);
    Timer(limit, () {
      isTimeUp = true;
      notifyListeners();
    });
  }

  void _scanImage(File image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final results = await _imageLabeler.processImage(visionImage);

    checkWords(results);
  }

  void checkWords(List<ImageLabel> scanResults) {
    hasMatch(scanResults).then((result) {
      if (result) {
        successVibrate();
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

  Future<bool> hasMatch(List<ImageLabel> scanResults) async {
    bool hasMatch = false;

    scanResults.forEach((results) {
      objects.where((hunt) => !hunt.isFound).forEach((words) {
        if (results.text.toLowerCase() == words.word.toLowerCase()) {
          hasMatch = true;
          words.isFound = true;
        }
      });
    });

    return hasMatch;
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
    Vibration.vibrate(pattern: [250, 500, 250, 500]);
  }

  void failVibrate() {
    Vibration.vibrate();
  }
}
