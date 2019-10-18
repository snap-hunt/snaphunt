import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/routes.dart';
import 'package:snaphunt/services/auth.dart';
import 'package:snaphunt/ui/home.dart';
import 'package:snaphunt/ui/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App(auth: await Auth.create()));
}

class App extends StatefulWidget {
  const App({
    Key key,
    @required this.auth,
  }) : super(key: key);

  final Auth auth;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.auth.init(_onUserChanged);
  }

  void _onUserChanged() {
    final user = widget.auth.currentUser.value;
    // User logged in
    if (currentUser == null && user != null) {
      _navigatorKey.currentState
          .pushNamedAndRemoveUntil(Router.home, (route) => false);
    }
    // User logged out
    else if (currentUser != null && user == null) {
      _navigatorKey.currentState
          .pushNamedAndRemoveUntil(Router.login, (route) => false);
    }
    currentUser = user;
  }

  @override
  void dispose() {
    widget.auth.dispose(_onUserChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider<Auth>.value(value: widget.auth),
        ValueListenableProvider<FirebaseUser>.value(
            value: widget.auth.currentUser),
      ],
      child: MaterialApp(
        title: 'SnapHunt',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.pink,
        ),
        navigatorKey: _navigatorKey,
        onGenerateRoute: Router.generateRoute,
        home: currentUser == null ? const Login() : const Home(),
      ),
    );
  }
}
