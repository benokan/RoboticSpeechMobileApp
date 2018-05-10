import 'package:flutter/material.dart';


class PlayGround extends StatefulWidget {
  @override
  PlayGroundState createState() {
    return new PlayGroundState();
  }

}

class PlayGroundState extends State<PlayGround> {

String x = "";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new ListView(
            children: <Widget>[
                (x=="")? new Text("PlaygGround") : new Text("")
            ],

        )

    );
  }
}