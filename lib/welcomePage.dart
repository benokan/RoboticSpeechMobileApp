import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'URL Launcher',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),

      home: new welcomePage(),
    );
  }
}

class welcomePage extends StatefulWidget {
  welcomePage({Key key}) : super(key: key);


  @override
  welcomePageState createState() => new welcomePageState();
}

class welcomePageState extends State<welcomePage> {


  Future<Null> _launched;

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }


  Widget _launchStatus(BuildContext context, AsyncSnapshot<Null> snapshot) {
    if (snapshot.hasError) {
      return new Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }


  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://roboticspeech.github.io';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome"),
        backgroundColor: Colors.deepOrangeAccent,
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
                color: Colors.deepOrangeAccent,
              ),
            ),
            new ListTile(
              title: new Text('Souffle Mode'),
              onTap: () {
                Navigator.of(context).pushNamed("/SoufflePage");
              },
            ),
            new ListTile(
              title: new Text('Remote Control'),
              onTap: () {
                Navigator.of(context).pushNamed("/RemoteControlPage");
              },
            ),

            new ListTile(
              title: new Text('Locations Page'),
              onTap: () {
                Navigator.of(context).pushNamed("/LocationsPage");
              },
            ),
            new ListTile(
              title: new Text('Ceyda Commands'),
              onTap: () {
                Navigator.of(context).pushNamed("/Ceyda");
              },
            ),
            new ListTile(
              title: new Text('PlayGround'),
              onTap: () {
                Navigator.of(context).pushNamed("/PlayGround");
              },
            ),

            new Image.asset('images/ekorob.png',height: 250.0,alignment: AlignmentDirectional.centerStart)

          ],
        ),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(toLaunch),
            ),
            new RaisedButton(
              onPressed: () => setState(() {
                _launched = _launchInBrowser(toLaunch);
              }),
              child: const Text('To the WebPage'),
            ),
            


            const Padding(padding: const EdgeInsets.all(16.0)),

            new FutureBuilder<Null>(future: _launched, builder: _launchStatus),
            new Image.asset('images/ekorob.png',height: 400.0,fit: BoxFit.cover,),

          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}