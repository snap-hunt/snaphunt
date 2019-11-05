import 'package:flutter/material.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/widgets/common/card_textfield.dart';
import 'package:snaphunt/widgets/multiplayer/create_buttons.dart';

class SinglePlayerSettings extends StatefulWidget {
  @override
  _SinglePlayerSettingsState createState() => _SinglePlayerSettingsState();
}

class _SinglePlayerSettingsState extends State<SinglePlayerSettings> {
  final itemsController = TextEditingController();
  int dropdownValue = 10;

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Settings',
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
              items: <int>[5, 10, 15, 30, 60]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value mins'),
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
              Navigator.of(context).pushReplacementNamed(
                Router.singlePlayer,
                arguments: [
                  int.parse(itemsController.text),
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
