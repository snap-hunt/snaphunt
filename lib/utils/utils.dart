import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
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
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

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

List<Hunt> generateWords([int numOfWords = 8]) {
  final box = Hive.box('words');

  final List words = box.get('words');
  words.shuffle();

  return new List<Hunt>.generate(numOfWords, (index) {
    return Hunt(word: words[index]);
  });
}
