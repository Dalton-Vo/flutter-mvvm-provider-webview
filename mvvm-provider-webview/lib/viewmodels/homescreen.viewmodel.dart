import 'dart:async';
import 'dart:convert';
import 'package:audio_session/audio_session.dart';
import 'package:coleman_shortcut/helpers/constant.dart';
import 'package:coleman_shortcut/routes/routers.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

/* ViewModels handles business logics and transform the models information into values to display on screen. Simply, they make connection between models and views. */
class HomeScreenVM with ChangeNotifier {
  bool mounted = true;
  Timer _timer;
  Future<void> init(BuildContext context, WebviewController controller) async {
    await controller.initialize();
    await controller.loadUrl('');
    notifyListeners();
  }
}
