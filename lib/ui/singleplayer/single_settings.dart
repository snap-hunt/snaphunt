import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snaphunt/router.gr.dart';
import 'package:snaphunt/widgets/common/card_textfield.dart';
import 'package:snaphunt/widgets/multiplayer/create_buttons.dart';

class SinglePlayerSettings extends StatefulWidget {
  @override
  _SinglePlayerSettingsState createState() => _SinglePlayerSettingsState();
}

class _SinglePlayerSettingsState extends State<SinglePlayerSettings> {
  final TextEditingController itemsController = TextEditingController();
  int gameDuration = 3;

  @override
  void initState() {
    itemsController.text = '8';
    super.initState();
  }

  @override
  void dispose() {
    itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final objectCount = Hive.box('words').get('words').length;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text(
          'Single player',
          style: TextStyle(color: Colors.white),
        ),
        leading: Container(),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 10),
          CardTextField(
            label: 'Time Limit',
            widget: DropdownButton<int>(
              isExpanded: true,
              value: gameDuration,
              iconSize: 24,
              elevation: 16,
              underline: Container(),
              onChanged: (newVal) {
                setState(() {
                  gameDuration = newVal;
                });
              },
              items: <int>[3, 5, 8, 12, 15]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    '$value mins',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          CardTextField(
            label: 'No. of Items',
            widget: TextField(
              controller: itemsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CreateButtons(
            createLabel: 'Play!',
            onCreate: () {
              int numObjects = int.parse(itemsController.text);

              if (numObjects == 0) {
                numObjects = 1;
              } else if (numObjects > (objectCount as num)) {
                numObjects = objectCount as int;
              }
              ExtendedNavigator.of(context).pushReplacementNamed(
                Routes.singlePlayer,
                arguments: SinglePlayerArguments(
                  numOfObjects: numObjects,
                  duration: gameDuration,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
