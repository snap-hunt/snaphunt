import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/services/auth.dart';
import 'package:snaphunt/services/connectivity.dart';
import 'package:snaphunt/utils/utils.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

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

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 36.0),
              const UserInfo(),
              const SizedBox(height: 16.0),
              FancyButton(
                child: Text(
                  "Singleplayer",
                  style: TextStyle(color: Colors.white),
                ),
                size: 70,
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pushNamed(Router.singlePlayerSettings);
                },
              ),
              const SizedBox(height: 16.0),
              FancyButton(
                child: Text(
                  "Multiplayer",
                  style: TextStyle(color: Colors.white),
                ),
                size: 70,
                color: connectionStatus == ConnectivityStatus.Offline
                    ? Colors.grey
                    : Colors.blue,
                onPressed: connectionStatus == ConnectivityStatus.Offline
                    ? () {
                        showAlertDialog(
                          context: context,
                          title: 'You are offline!',
                          body: 'Internet connection is needed to play online',
                        );
                      }
                    : () {
                        Navigator.of(context).pushNamed(Router.lobby);
                      },
              ),
              const SizedBox(height: 16.0),
              FancyButton(
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  Auth.of(context).logout();
                },
                color: Colors.red,
                size: 40,
              ),
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
              fontSize: 32,
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

  const UserAvatar({
    Key key,
    this.photoUrl,
    this.height = 96.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 2.0,
          shape: const CircleBorder(
            side: BorderSide(color: Colors.orange, width: 3.0),
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
