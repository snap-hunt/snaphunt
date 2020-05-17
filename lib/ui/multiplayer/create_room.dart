import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/router.gr.dart';
import 'package:snaphunt/widgets/common/card_textfield.dart';
import 'package:snaphunt/widgets/multiplayer/create_buttons.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController maxPlayersController = TextEditingController();
  final TextEditingController itemsController = TextEditingController();
  int dropdownValue = 3;

  @override
  void initState() {
    nameController.text = "Snap Attack '19";
    maxPlayersController.text = '3';
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
    final objectCount = Hive.box('words').get('words').length;

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
        physics: const NeverScrollableScrollPhysics(),
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
              items: <int>[3, 5, 8, 12, 15]
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
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          CreateButtons(
            onCreate: () async {
              int numObjects = int.parse(itemsController.text);

              if (numObjects == 0) {
                numObjects = 1;
              } else if (numObjects > (objectCount as num)) {
                numObjects = objectCount as int;
              }

              final Game game = Game(
                name: nameController.text,
                maxPlayers: int.parse(maxPlayersController.text),
                noOfItems: numObjects,
                timeLimit: dropdownValue,
                status: 'waiting',
                createdBy: user.uid,
                timeCreated: DateTime.fromMillisecondsSinceEpoch(
                    Timestamp.now().millisecondsSinceEpoch),
              );

              ExtendedNavigator.of(context).pushReplacementNamed(
                Routes.room,
                arguments: RoomArguments(
                  game: game,
                  userId: user.uid,
                  isHost: true,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
