import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/widgets/common/card_textfield.dart';
import 'package:snaphunt/widgets/multiplayer/create_buttons.dart';

class SinglePlayerSettings extends StatefulWidget {
  @override
  _SinglePlayerSettingsState createState() => _SinglePlayerSettingsState();
}

class _SinglePlayerSettingsState extends State<SinglePlayerSettings> {
  final itemsController = TextEditingController();
  int dropdownValue = 3;

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
        title: Text(
          'Single player',
          style: TextStyle(color: Colors.white),
        ),
        leading: Container(),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          const SizedBox(height: 10),
          CardTextField(
            label: 'Time Limit',
            widget: DropdownButton<int>(
              isExpanded: true,
              value: dropdownValue,
              iconSize: 24,
              elevation: 16,
              underline: Container(),
              onChanged: (newVal) {
                setState(() {
                  dropdownValue = newVal;
                });
              },
              items: <int>[3, 5, 8, 12, 15]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    '$value mins',
                    style: TextStyle(
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
              maxLines: 1,
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
              } else if (numObjects > objectCount) {
                numObjects = objectCount;
              }
              
              Navigator.of(context).pushReplacementNamed(
                Router.singlePlayer,
                arguments: [
                  numObjects,
                  dropdownValue,
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
