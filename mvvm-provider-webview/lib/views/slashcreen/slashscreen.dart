import 'dart:async';
import 'dart:convert';

import 'package:coleman_shortcut/helpers/constant.dart';
import 'package:coleman_shortcut/viewmodels/slashscreen.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

// import 'dart:html';
class Slashscreen extends StatefulWidget {
  const Slashscreen({Key key}) : super(key: key);

  @override
  _SlashscreenState createState() => _SlashscreenState();
}

class _SlashscreenState extends State<Slashscreen> with WidgetsBindingObserver {
  final WebviewController __controller = WebviewController();

  @override
  void initState() {
    Future(() async {
      context.read<SlashscreenVM>().init(context, __controller).then((_) {
        __controller.loadUrl(Constant.URL_FIRST);
        setState(() {});
      });
      context.read<SlashscreenVM>().playmusic();

      context.read<SlashscreenVM>().timeOutCallBack(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          __controller.value.isInitialized
              ? Webview(__controller)
              : const Text('Not Initialized'),
          SizedBox.expand(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapDown: (_) {
                context.read<SlashscreenVM>().timeOutCallBack(context);
              },
              onTap: () {
                context.read<SlashscreenVM>().timeOutCallBack(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
