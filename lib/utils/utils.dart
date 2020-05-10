import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snaphunt/model/hunt.dart';
import 'package:snaphunt/widgets/common/fancy_alert_dialog.dart';
import 'package:flutter/services.dart' show rootBundle;

void showAlertDialog({BuildContext context, String title, String body}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => FancyAlertDialog(
      title: title,
      body: body,
    ),
  );
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/default.json');
}

Future openDB() async {
  await Hive.initFlutter();

  return Future.wait([
    Hive.openBox('words'),
  ]);
}

void initDB() async {
  final box = Hive.box('words');

  if (box.isEmpty) {
    Map<String, dynamic> data = json.decode(await loadAsset());

    box.put('version', data['version']);
    box.put('words', data['words']);
  }
}

List<String> generateWords([int numOfWords = 8]) {
  final box = Hive.box('words');

  final List words = box.get('words');
  words.shuffle();

  return List<String>.generate(numOfWords, (index) => words[index]);
}

List<Hunt> generateHuntObjects([int numOfWords = 8]) {
  final List words = generateWords(numOfWords);

  return new List<Hunt>.generate(numOfWords, (index) {
    return Hunt(word: words[index]);
  });
}

List<Hunt> generateHuntObjectsFromList(List<String> words) {
  return new List<Hunt>.generate(words.length, (index) {
    return Hunt(word: words[index]);
  });
}
