import 'dart:async';

import 'package:coleman_shortcut/helpers/constant.dart';
import 'package:coleman_shortcut/routes/routers.dart';
import 'package:coleman_shortcut/viewmodels/homescreen.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

/* Views handle UI part of the application. It is the connection between user and application.*/
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WebviewController __controller = WebviewController();

  void initState() {
    Future(() async {
      context.read<HomeScreenVM>().init(context, __controller).then((_) {
        __controller.loadUrl(Constant.URL_SECOND);
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox.expand(
          child: __controller.value.isInitialized
              ? Webview(__controller)
              : const Text('Not Initialized'),
        ),
        //Tap screen will push to slash screen
        SizedBox.expand(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(builder: (context) {
                  return InkWell(
                    onTap: () => Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed(RouteManagers.slashScreen),
                  );
                });
              },
            ),
          ),
        )
      ],
    ));
  }
}
