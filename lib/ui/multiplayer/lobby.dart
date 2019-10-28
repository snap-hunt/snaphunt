import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/multiplayer/join_room_dialog.dart';
import 'package:snaphunt/widgets/multiplayer/lobby_buttons.dart';

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

                  if (roomCode != null && roomCode.isNotEmpty) {
                    final game =
                        await Repository.instance.retrieveGame(roomCode);

                    if (game == null) {
                      showAlertDialog(
                        context: context,
                        title: 'Invalid Code',
                        body: 'Invalid code. Game does not exist!',
                      );
                    } else {
                      if (game.status != 'waiting') {
                        showAlertDialog(
                          context: context,
                          title: 'Game not available!',
                          body: 'Game has already started or ended!',
                        );
                      } else {
                        final user =
                            Provider.of<FirebaseUser>(context, listen: false);

                        Navigator.of(context).pushNamed(Router.room,
                            arguments: [game, false, user.uid]);
                      }
                    }
                  }
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
                onRoomClick: () async {
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
  String _createdBy = '';
  bool _isRoomFull = false;

  @override
  void initState() {
    getName();
    super.initState();
  }

  void getName() async {
    String name = await Repository.instance.getUserName(widget.game.createdBy);

    setState(() {
      _createdBy = name;
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
            subtitle: Text(_createdBy),
            trailing: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${widget.game.timeLimit} mins'),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('games')
                      .document(widget.game.id)
                      .collection('players')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Text('0/${widget.game.maxPlayers}');
                    }

                    final players = snapshot.data.documents.length;
                    final isRoomFull = players == widget.game.maxPlayers;

                    return Text(
                      '$players/${widget.game.maxPlayers}',
                      style: TextStyle(color: isRoomFull ? Colors.red : null),
                    );
                  },
                ),
              ],
            ),
            onTap: _isRoomFull ? null : widget.onRoomClick,
          ),
        ),
      ),
    );
  }
}
