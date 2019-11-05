import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/widgets/common/card_textfield.dart';
import 'package:snaphunt/widgets/multiplayer/create_buttons.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final nameController = TextEditingController();
  final maxPlayersController = TextEditingController();
  final itemsController = TextEditingController();
  int dropdownValue = 10;

  @override
  void initState() {
    nameController.text = 'Snap Hunt!';
    maxPlayersController.text = '5';
    itemsController.text = '8';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    maxPlayersController.dispose();
    itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'New Hunt Room',
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
            label: 'Room Name',
            widget: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          CardTextField(
            label: 'Max Players',
            widget: TextField(
              controller: maxPlayersController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
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
            onCreate: () async {
              Game game = Game(
                name: nameController.text,
                maxPlayers: int.parse(maxPlayersController.text),
                noOfItems: int.parse(itemsController.text),
                timeLimit: dropdownValue,
                status: 'waiting',
                createdBy: user.uid,
                timeCreated: DateTime.fromMillisecondsSinceEpoch(
                    Timestamp.now().millisecondsSinceEpoch),
              );
              Navigator.of(context).pushReplacementNamed(
                Router.room,
                arguments: [game, true, user.uid],
              );
            },
          )
        ],
      ),
    );
  }
}