import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snaphunt/model/game.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/stores/game_model.dart';

class RoomB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (model.isGameStart) {
              Navigator.of(context).pushNamed(Router.game);
            }

            if (model.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: <Widget>[
                RoomDetails(game: model.game),
              ],
            );
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
