import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/constants/game_status_enum.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/stores/game_model.dart';
import 'package:snaphunt/widgets/fancy_alert_dialog.dart';
import 'package:snaphunt/widgets/fancy_button.dart';
import 'package:snaphunt/widgets/multiplayer/room_exit_dialog.dart';

class Room extends StatelessWidget {
  void showAlertDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => FancyAlertDialog(
        title: title,
        body: body,
      ),
    );
  }

  void listener(GameModel model, BuildContext context) {
    if (GameStatus.full == model.status) {
      Navigator.of(context).pop();
      showAlertDialog(context, 'Room Full', 'Room already reached max players');
    }

    if (GameStatus.game == model.status) {
      Navigator.of(context).pushReplacementNamed(Router.game);
    }

    if (GameStatus.cancelled == model.status) {
      Navigator.of(context).pop();
      showAlertDialog(context, 'Game Cancelled', 'Game was cancelled by host!');
    }

    if (GameStatus.kicked == model.status) {
      Navigator.of(context).pop();
      showAlertDialog(context, 'Kicked', 'You were kicked by the host!');
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
              title: _isHost ? 'Delete room?' : 'Leave room?',
              body: _isHost
                  ? 'Room will be deleted aheheheheheh'
                  : 'Are you sure you want to leave from the room?',
            );
          },
        );

        return roomCode;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Room',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Consumer<GameModel>(
            builder: (context, model, child) {
              _isHost = model.isHost;

              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              WidgetsBinding.instance
                  .addPostFrameCallback((_) => listener(model, context));

              return Column(
                children: <Widget>[
                  RoomDetails(game: model.game),
                ],
              );
            },
          ),
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
          // PlayerRow(players: 0, max: 6),
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
