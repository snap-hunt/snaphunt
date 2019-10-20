import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/widgets/fancy_button.dart';

class Room extends StatefulWidget {
  final Game game;
  final bool isHost;

  const Room({Key key, this.game, this.isHost = false}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  final repository = Repository.instance;
  Future<String> _roomId;
  FirebaseUser _user;

  @override
  void initState() {
    if (widget.isHost) {
      initRoom();
    } else {
      _roomId = Future.value(widget.game.id);
    }
    super.initState();
  }

  void initRoom() async {
    _roomId = repository.createRoom(widget.game);
  }

  void joinRoom() async {
    repository.joinRoom(widget.game.id, _user.uid);
  }

  @override
  void dispose() {
    if (widget.isHost) {
      repository.cancelRoom(widget.game.id);
    } else {
      repository.leaveRoom(widget.game.id, _user.uid);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<FirebaseUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Room',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: _roomId,
          builder: (context, data) {
            if (data.hasData || data.data != null) {
              widget.game.id = data.data;
              joinRoom();

              return Column(
                children: <Widget>[
                  RoomDetails(game: widget.game),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .document('games/${widget.game.id}')
                          .collection('players')
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

                        return RoomBody();
                      },
                    ),
                  )
                ],
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class RoomDetails extends StatelessWidget {
  final Game game;

  const RoomDetails({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(game.name),
          Text('${game.timeLimit} min'),
          Text('Hunt time'),
          QrImage(
            data: game.id,
            version: QrVersions.auto,
            size: 150.0,
          ),
          Text(game.id)
        ],
      ),
    );
  }
}

class RoomBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FancyButton(
            child: Text(
              'BEGIN HUNT',
              style: fancy_button_style,
            ),
            color: Colors.deepOrangeAccent,
            size: 60,
            onPressed: () {},
          ),
          SizedBox(height: 10),
          PlayerRow(players: 0, max: 6),
        ],
      ),
    );
  }
}

class PlayerRow extends StatelessWidget {
  final int players;
  final int max;

  const PlayerRow({Key key, this.players, this.max}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[600],
      height: 45,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'PLAYERS',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '$players/$max',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
