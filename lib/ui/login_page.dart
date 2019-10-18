import 'package:flutter/material.dart';
import 'package:snaphunt/services/auth.dart';

class Login extends StatefulWidget {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
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
                        RaisedButton(
                          onPressed: _onLoginWithGooglePressed,
                          child: const Text('LOGIN WITH GOOGLE'),
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
