import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
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
              );
              Navigator.of(context).popAndPushNamed(
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

class CardTextField extends StatelessWidget {
  final String label;
  final Widget widget;

  const CardTextField({
    Key key,
    this.label,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 3,
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(label),
                ),
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: widget,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
