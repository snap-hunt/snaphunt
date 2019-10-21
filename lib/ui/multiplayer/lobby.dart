import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/widgets/multiplayer/join_room_dialog.dart';
import 'package:snaphunt/widgets/multiplayer/room_buttons.dart';

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SNAPHUNT',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              LobbyButtons(
                onCreateRoom: () {
                  Navigator.of(context).pushNamed(Router.create);
                },
                onJoinRoom: () async {
                  String roomCode = await showDialog<String>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => JoinRoom(),
                  );

                  final game = await Repository.instance.retrieveGame(roomCode);
                  final user =
                      Provider.of<FirebaseUser>(context, listen: false);
                  Navigator.of(context).pushNamed(Router.room,
                      arguments: [game, false, user.uid]);
                },
              ),
              Expanded(
                child: LobbyList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LobbyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('games')
            .where('status', isEqualTo: 'waiting')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (snapshot.data.documents.isEmpty) {
            return Container(
              child: Text('empty'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              final game = Game.fromJson(snapshot.data.documents[index].data);
              game.id = snapshot.data.documents[index].documentID;

              return LobbyListTile(
                game: game,
                onRoomClick: () {
                  final user =
                      Provider.of<FirebaseUser>(context, listen: false);
                  Navigator.of(context).pushNamed(Router.room,
                      arguments: [game, false, user.uid]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class LobbyListTile extends StatefulWidget {
  final Game game;
  final Function onRoomClick;

  const LobbyListTile({
    Key key,
    this.onRoomClick,
    this.game,
  }) : super(key: key);

  @override
  _LobbyListTileState createState() => _LobbyListTileState();
}

class _LobbyListTileState extends State<LobbyListTile> {
  String createdBy = '';

  @override
  void initState() {
    getName();
    super.initState();
  }

  void getName() async {
    String name = await Repository.instance.getUserName(widget.game.createdBy);

    setState(() {
      createdBy = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            title: Text(widget.game.name),
            subtitle: Text(createdBy),
            trailing: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${widget.game.timeLimit} mins'),
                Text('0/${widget.game.maxPlayers}'),
              ],
            ),
            onTap: widget.onRoomClick,
          ),
        ),
      ),
    );
  }
}
