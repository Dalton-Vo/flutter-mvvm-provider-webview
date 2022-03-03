import 'dart:async';
import 'dart:convert';
import 'package:audio_session/audio_session.dart';
import 'package:coleman_shortcut/helpers/constant.dart';
import 'package:coleman_shortcut/routes/routers.dart';
import 'package:coleman_shortcut/views/slashcreen/widgets/dialogbutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

/* ViewModels handles business logics and transform the models information into values to display on screen. Simply, they make connection between models and views. */

class SlashscreenVM extends ChangeNotifier {
  bool mounted = true;
  Timer _timer;
  String deviceId;
  final player = AudioPlayer();
  //Initialized encode for user agent
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  // WebviewController _controller;
  Future<void> playmusic() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
      player.play();

      notifyListeners();
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  Future<void> init(BuildContext context, WebviewController controller) async {
    await controller.initialize();
    await controller.loadUrl('');
    notifyListeners();
    try {
      String _deviceId;

      controller.url.listen((url) {
        print(url);
      });

      _deviceId = await PlatformDeviceId.getDeviceId;
      String encoded = stringToBase64.encode(_deviceId);

      print("deviceId->$_deviceId");
      await controller.setUserAgent("$encoded");
      if (!mounted) return;
      // setState(() {});
      notifyListeners();
    } on PlatformException catch (e) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${e.code}'),
                      Text('Message: ${e.message}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }

  void timeOutCallBack(BuildContext context) async {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 5), () => aleart(context));
    // notifyListeners();
  }

  void aleart(BuildContext context) async {
    _timer?.cancel();
    _timer = null;
    showDialog(
      builder: (BuildContext context) {
        return const CustomDialog();
      },
      context: context,
      barrierDismissible: false,
    ).then((_) {
      // dispose the timer in case something else has triggered the dismiss.
      // _timer?.cancel();
      // _timer = null;
    });
    routeHomePage(context);
    // notifyListeners();
  }

  void routeHomePage(BuildContext context) async {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: 10), () {
      player.stop();
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(RouteManagers.homeScreen);
    });
    notifyListeners();
  }

  void routescreen(BuildContext context) async {}

  @override
  void reassemble() {
    // TODO: implement reassemble
  }
}
