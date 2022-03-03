import 'package:coleman_shortcut/views/homescreen.dart';
import 'package:coleman_shortcut/views/slashcreen/slashscreen.dart';
import 'package:coleman_shortcut/views/slashcreen/widgets/dialogbutton.dart';
import 'package:flutter/material.dart';

class RouteManagers {
  static const String slashScreen = '/';
  static const String homeScreen = '/home_screen';
  static const String widgetbutton = '/widgetbutton';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case slashScreen:
        return MaterialPageRoute(builder: (context) => Slashscreen());
      case homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      default:
        throw const FormatException('Route not found');
    }
  }
}
