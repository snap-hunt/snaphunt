import 'package:flutter/material.dart';
import 'package:snaphunt/ui/home_page.dart';
import 'package:snaphunt/ui/login_page.dart';


class Router {
  static const String home = '/';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => Login());

      case home:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
