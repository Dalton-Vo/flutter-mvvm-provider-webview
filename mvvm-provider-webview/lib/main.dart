import 'package:coleman_shortcut/helpers/constant.dart';
//Route must truth to use onGenerateroute
import 'package:coleman_shortcut/routes/routers.dart';
import 'package:coleman_shortcut/viewmodels/homescreen.viewmodel.dart';
import 'package:coleman_shortcut/viewmodels/slashscreen.viewmodel.dart';
import 'package:coleman_shortcut/views/slashcreen/slashscreen.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(Constant.WIDTH, Constant.HEIGHT);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SlashscreenVM>(
            create: (BuildContext context) => SlashscreenVM()),
        ChangeNotifierProvider<HomeScreenVM>(
            create: (BuildContext context) => HomeScreenVM()),
      ],
      child: MaterialApp(
        title: 'Welcome to Flutter',
        initialRoute: RouteManagers.slashScreen,
        onGenerateRoute: RouteManagers.generateRoute,
      ),
    );
  }
}
