import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/services/auth.dart';
import 'package:snaphunt/services/connectivity.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';
import 'package:snaphunt/widgets/common/wave.dart';

class Home extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const Home(),
    );
  }

  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class HomeFancyButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final Widget child;
  final double width;

  const HomeFancyButton(
      {Key key,
      this.text,
      this.color,
      this.onPressed,
      this.child,
      this.width = 220})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyButton(
      child: SizedBox(
        width: width,
        child: child,
      ),
      size: 70,
      color: color,
      onPressed: onPressed,
    );
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                color: Colors.white,
                child: Image.asset('assets/main.png', height: 185),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const UserInfo(),
                  const SizedBox(height: 32.0),
                  HomeFancyButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Singleplayer",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ]),
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Router.singlePlayerSettings);
                    },
                  ),
                  const SizedBox(height: 18.0),
                  HomeFancyButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Multiplayer",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ]),
                    color: connectionStatus == ConnectivityStatus.Offline
                        ? Colors.grey
                        : Colors.blue,
                    onPressed: connectionStatus == ConnectivityStatus.Offline
                        ? () {
                            showAlertDialog(
                              context: context,
                              title: 'You are offline!',
                              body:
                                  'Internet connection is needed to play online',
                            );
                          }
                        : () {
                            Navigator.of(context).pushNamed(Router.lobby);
                          },
                  ),
                  const SizedBox(height: 18.0),
                  Container(
                    child: HomeFancyButton(
                      width: 125,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 2),
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ))
                        ],
                      ),
                      onPressed: () {
                        Auth.of(context).logout();
                      },
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              CustomWaveWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context, listen: false);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAvatar(
            photoUrl: user.photoUrl,
          ),
          SizedBox(width: 15),
          Text(
            user.displayName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
          )
        ],
      ),
    );
  }
}

/// Displays the user's image
class UserAvatar extends StatelessWidget {
  final String photoUrl;
  final double height;
  final Color borderColor;

  const UserAvatar({
    Key key,
    this.photoUrl,
    this.height = 70.0,
    this.borderColor = Colors.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 2.0,
          shape: CircleBorder(
            side: BorderSide(color: borderColor, width: 3.0),
          ),
          color: Colors.black,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: height,
            height: height,
            child: photoUrl != null
                ? Image.network(photoUrl)
                : Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 72.0,
                  ),
          ),
        ),
      ],
    );
  }
}
