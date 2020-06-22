import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/data/repository.dart';
import 'package:snaphunt/model/player.dart';
import 'package:snaphunt/router.gr.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';
import 'package:snaphunt/widgets/multiplayer/room_loading.dart';

class ResultMultiPlayer extends StatefulWidget {
  final String gameId;
  final String title;
  final int duration;

  const ResultMultiPlayer({
    Key key,
    this.gameId,
    this.title,
    this.duration,
  }) : super(key: key);

  @override
  _ResultMultiPlayerState createState() => _ResultMultiPlayerState();
}

class _ResultMultiPlayerState extends State<ResultMultiPlayer> {
  List<Player> _players;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    initPlayers();
  }

  Future<void> initPlayers() async {
    final players = await Repository.instance.getPlayers(widget.gameId);
    players.sort((a, b) => b.score.compareTo(a.score));
    setState(() {
      _players = players;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          child: _players == null
              ? RoomLoading()
              : Column(
                  children: <Widget>[
                    Screenshot(
                      controller: screenshotController,
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            ResultHeader(
                              title: widget.title,
                              duration: widget.duration,
                            ),
                            ResultWinner(winner: _players.first),
                            Divider(
                              color: Colors.grey,
                              thickness: 2,
                              indent: 0,
                              endIndent: 0,
                            ),
                            ResultPlayers(
                              players: _players.sublist(1, _players.length),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FancyButton(
                      color: Colors.orange,
                      size: 50,
                      onPressed: () async {
                        screenshotController.capture().then((File image) async {
                          await Share.file(
                              'SnapHunt',
                              'snaphunt.png',
                              image.readAsBytesSync().buffer.asUint8List(),
                              'image/png');
                        }).catchError((onError) {
                          print(onError);
                        });
                      },
                      child: Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Icon(Icons.share, color: Colors.white),
                            ),
                            Text(
                              'Share',
                              style: fancyButtonStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FancyButton(
                      color: Colors.deepOrange,
                      size: 50,
                      onPressed: () {
                        ExtendedNavigator.of(context)
                            .popUntil(ModalRoute.withName(Routes.lobby));
                      },
                      child: Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                            ),
                            Text(
                              'Return to Lobby',
                              style: fancyButtonStyle,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class ResultHeader extends StatelessWidget {
  final String title;
  final int duration;

  const ResultHeader({Key key, this.title, this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16.0, MediaQuery.of(context).padding.top + 8, 16.0, 16.0),
      height: MediaQuery.of(context).size.height * 0.23,
      color: Colors.orange,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ResultHeaderLogo(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '$duration min',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Hunt Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ResultHeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shape: const CircleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple[300],
        ),
        height: 120,
        width: 120,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/trophy.png',
          height: 80,
        ),
      ),
    );
  }
}

class ResultWinner extends StatelessWidget {
  final Player winner;

  const ResultWinner({Key key, this.winner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserAvatar(
                photoUrl: winner.user.photoUrl,
                height: 100,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'WINNER',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                winner.user.displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                '${winner.score} points',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ResultPlayers extends StatelessWidget {
  final List<Player> players;

  const ResultPlayers({Key key, this.players}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];

          return ListTile(
            leading: UserAvatar(
              borderColor: userColors[(index + 1) % 4],
              photoUrl: player.user.photoUrl,
              height: 50,
            ),
            title: Text(
              player.user.displayName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Text(
              '${player.score} points',
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          );
        },
      ),
    );
  }
}
