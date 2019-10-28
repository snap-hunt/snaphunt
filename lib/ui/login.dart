import 'package:flutter/material.dart';
import 'package:snaphunt/services/auth.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

class Login extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const Login(),
    );
  }

  const Login({
    Key key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future _loginFuture;

  void _onLoginWithGooglePressed() {
    setState(() {
      _loginFuture = Auth.of(context).loginWithGoogle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'SnapHunt',
                style: TextStyle(fontSize: 42),
              ),
              FutureBuilder(
                future: _loginFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      children: <Widget>[
                        FancyButton(
                          child: Text(
                            'Login with Google',
                            style: TextStyle(color: Colors.white),
                          ),
                          size: 60,
                          color: Colors.red,
                          onPressed: _onLoginWithGooglePressed,
                        ),
                        if (snapshot.hasError)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 36.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).errorColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2.0)),
                              color:
                                  Theme.of(context).errorColor.withOpacity(0.6),
                            ),
                            child: Text(
                              snapshot.error.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
