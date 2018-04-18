import 'package:flutter/material.dart';
import 'main.dart';

class welcomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcoming page"),
      ),
      drawer: new Drawer(

        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Menu'),
              decoration: new BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            new ListTile(
              title: new Text('Souffle Mode'),
              onTap: () {
                Navigator.of(context).pushNamed("/SoufflePage");
                // Update the state of the app
                // ...

              },
            ),
            new ListTile(
              title: new Text('Remote Control'),
              onTap: () {
                Navigator.of(context).pushNamed("/RemoteControlPage");
                // ...

              },
            ),
          ],
        ),
      ),

    );
  }
}