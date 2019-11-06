import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/constants/game_status_enum.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/stores/game_model.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';
import 'package:snaphunt/widgets/multiplayer/host_start_button.dart';
import 'package:snaphunt/widgets/multiplayer/player_await_button.dart';
import 'package:snaphunt/widgets/multiplayer/room_exit_dialog.dart';
import 'package:snaphunt/widgets/multiplayer/room_loading.dart';

class Room extends StatelessWidget {
  void gameStatusListener(GameModel model, BuildContext context) {
    if (GameStatus.full == model.status) {
      Navigator.of(context).pop();
      showAlertDialog(
        context: context,
        title: 'Room Full',
        body: 'Room already reached max players',
      );
    }

    if (GameStatus.game == model.status) {
      Navigator.of(context).pushReplacementNamed(
        Router.game,
        arguments: [
          model.game,
          model.userId,
          model.players,
        ],
      );
    }

    if (GameStatus.cancelled == model.status) {
      Navigator.of(context).pop();
      showAlertDialog(
        context: context,
        title: 'Game Cancelled',
        body: 'Game was cancelled by host!',
      );
    }

    if (GameStatus.kicked == model.status) {
      Navigator.of(context).pop();
      showAlertDialog(
        context: context,
        title: 'Kicked',
        body: 'You were kicked by the host!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isHost = false;

    return WillPopScope(
      onWillPop: () async {
        final roomCode = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return RoomExitDialog(
              title: _isHost ? 'Delete room' : 'Leave room',
              body: _isHost
                  ? 'Leaving the room will cancel the game'
                  : 'Are you sure you want to leave from the room?',
            );
          },
        );

        return roomCode;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Room',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: Consumer<GameModel>(
            builder: (context, model, child) {
              _isHost = model.isHost;

              if (model.isLoading) {
                return RoomLoading();
              }

              WidgetsBinding.instance.addPostFrameCallback(
                (_) => gameStatusListener(model, context),
              );

              return child;
            },
            child: Column(
              children: <Widget>[
                RoomDetails(),
                RoomBody(),
                PlayerRow(),
                PlayerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoomDetails extends StatelessWidget {
  const RoomDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, model, child) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(model.game.name),
            Text('${model.game.timeLimit} min'),
            Text('Hunt time'),
            QrImage(
              data: model.game.id,
              version: QrVersions.auto,
              size: 150.0,
            ),
            Text(model.game.id)
          ],
        ),
      );
    });
  }
}

class RoomBody extends StatelessWidget {
  const RoomBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, child) {
        if (!model.isHost) {
          return PlayerAwaitButton(
            canStartGame: model.canStartGame,
          );
        }

        return HostStartButton(
          canStartGame: model.canStartGame,
          // canStartGame: true,
          onGameStart: model.onGameStart,
        );
      },
    );
  }
}

class PlayerRow extends StatelessWidget {
  const PlayerRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, child) {
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
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '${model.players.length}/${model.game.maxPlayers}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PlayerList extends StatelessWidget {
  const PlayerList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(
      builder: (context, model, child) {
        return Container(
          height: 150, //TODO dynamic height
          child: ListView.builder(
            itemCount: model.players.length,
            itemBuilder: (context, index) {
              final player = model.players[index];
              final isMe = player.user.uid == model.userId;

              return Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  title: Text(
                    player.user.displayName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: UserAvatar(
                    photoUrl: player.user.photoUrl,
                    height: 45,
                    borderColor: user_colors[index % 4],
                  ),
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage(player.user.photoUrl),
                  // ),
                  trailing: model.isHost
                      ? !isMe
                          ? FancyButton(
                              child: Text(
                                'REMOVE',
                                style: fancy_button_style,
                              ),
                              color: Colors.red,
                              size: 30,
                              onPressed: () =>
                                  model.onKickPlayer(player.user.uid),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            )
                      : Container(
                          height: 0,
                          width: 0,
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
