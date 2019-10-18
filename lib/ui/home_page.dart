import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/services/auth.dart';

class Home extends StatefulWidget {

  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 36.0),
              const UserAvatar(),
              const SizedBox(height: 16.0),
              RaisedButton(
                onPressed: () {
                  Auth.of(context).logout();
                },
                child: const Text('LOGOUT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays the user's image
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context, listen: false);
    return Column(
      children: <Widget>[
        Material(
          elevation: 4.0,
          shape: const CircleBorder(
            side: BorderSide(color: Colors.blue, width: 6.0),
          ),
          color: Colors.black,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 96.0,
            height: 96.0,
            child: user?.photoUrl != null
                ? Image.network(user.photoUrl)
                : Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 72.0,
                  ),
          ),
        ),
        SizedBox(height: 10),
        Text(user.displayName)
      ],
    );
  }
}
