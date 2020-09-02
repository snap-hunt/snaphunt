import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/router.gr.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/animations/popup_dialog.dart';
import 'package:snaphunt/widgets/multiplayer/join_room_dialog.dart';
import 'package:snaphunt/widgets/multiplayer/lobby_buttons.dart';

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SNAPHUNT LOBBY',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: LobbyList(),
              ),
              const Divider(
                thickness: 1.5,
              ),
              LobbyButtons(
                onCreateRoom: () {
                  ExtendedNavigator.of(context).pushCreateRoom();
                },
                onJoinRoom: () async {
                  final String roomCode = await showPopupDialog<String>(
                    context,
                    JoinRoom(),
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
                        final user = Provider.of<User>(context, listen: false);

                        ExtendedNavigator.of(context).pushRoom(
                          game: game,
                          userId: user.uid,
                          isHost: false,
                        );
                      }
                    }
                  }
                },
              ),
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('games')
          .where('status', isEqualTo: 'waiting')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data.docs.isEmpty) {
          return Center(
            child: Text(
              'No rooms available',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }
        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final game = Game.fromFirestore(snapshot.data.docs[index]);

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 650),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: LobbyListTile(
                      game: game,
                      onRoomClick: () async {
                        final user = Provider.of<User>(context, listen: false);

                        ExtendedNavigator.of(context).pushRoom(
                          game: game,
                          userId: user.uid,
                          isHost: false,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class LobbyListTile extends StatefulWidget {
  final Game game;
  final VoidCallback onRoomClick;

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
  final bool _isRoomFull = false;

  @override
  void initState() {
    getName();
    super.initState();
  }

  Future<void> getName() async {
    final name = widget.game.hostName ??
        await Repository.instance.getUserName(widget.game.createdBy);

    if (mounted) {
      setState(() {
        _createdBy = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            title: Text(
              widget.game.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(_createdBy),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${widget.game.timeLimit} mins'),
                const SizedBox(height: 8.0),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('games')
                      .doc(widget.game.id)
                      .collection('players')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Text('0/${widget.game.maxPlayers}');
                    }

                    final players = snapshot.data.docs.length;
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
