import 'dart:async';

import 'package:coleman_shortcut/routes/routers.dart';
import 'package:coleman_shortcut/viewmodels/slashscreen.viewmodel.dart';
import 'package:coleman_shortcut/views/slashcreen/slashscreen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 3,
                ),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text("まだみていますか",
                      style: TextStyle(fontSize: 30.0, color: Colors.red)),
                ) //
                    ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context
                    // RouteManagers.slashScreen,
                    // ModalRoute.withName('/'),
                    );
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.cancel_rounded, size: 30, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
