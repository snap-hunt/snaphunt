import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snaphunt/constants/game_status_enum.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/stores/game_model.dart';
import 'package:snaphunt/widgets/fancy_alert_dialog.dart';
import 'package:snaphunt/widgets/multiplayer/room_exit_dialog.dart';

class RoomB extends StatelessWidget {
  listener(GameModel model, BuildContext context) {
    if (model.status == GameStatus.cancelled) {
      showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => FancyAlertDialog(
          title: 'Game Cancelled',
          body: 'Game was cancelled by host!',
        ),
      );
      Navigator.of(context).pop(GameStatus.cancelled);
    }

    if (model.status == GameStatus.game) {
      Navigator.of(context).pushReplacementNamed(Router.game);
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
