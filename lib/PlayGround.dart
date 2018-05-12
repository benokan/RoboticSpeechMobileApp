import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'welcomePage.dart';
import 'remoteControlPage.dart';
import 'LocationPage.dart';
import 'Ceyda.dart';
import 'PlayGround.dart';


class PlayGround extends StatefulWidget {
  @override
  PlayGroundState createState() {
    return new PlayGroundState();
  }

}

class PlayGroundState extends State<PlayGround> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StreamBuilder<Event>(
      stream: FirebaseDatabase.instance.reference().child('location').onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> event) {
        if (!event.hasData)
          return new Center(child: new Text('Loading...'));
        String location = event.data.snapshot.value;
          return new Center(child:new Text(location));
      },
    );
  }
}