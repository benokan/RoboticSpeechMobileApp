import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'welcomePage.dart';
import 'remoteControlPage.dart';

void main() {
  runApp(new MaterialApp(
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        "/WelcomePage": (BuildContext context) => new welcomePage(),
        "/SoufflePage": (BuildContext context) => new SoufflePage(),
        "/RemoteControlPage": (BuildContext context) => new remoteControlPage(),
        "/HomePage": (BuildContext context) => new MyHomePage(),
      }
  ));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) :super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State <MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }


  final FirebaseDatabase _fireBase = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();


  Future<FirebaseUser> signIn(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    print("User Name: ${user.displayName}"); // Console log
    if (user.displayName == "Benokan Kafkas" ||
        user.displayName == "Mustafa Teyfik Avkan" ||
        user.displayName == "Gökhan Tok" ||
        user.displayName == "Gazihan Alankuş") {
      Navigator.of(context).pushNamed("/WelcomePage");
    }

    return user;
  }

  void signOut() {
    googleSignIn.signOut();
    print("User Signed out");
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Firebase Demo"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton( // button1 - SignIn
              onPressed: () =>
                  signIn(context)
                      .then((FirebaseUser user) => print(user))
                      .catchError((e) => print(e)),
              child: new Text("Sign in"),
              color: Colors.green,
            ), //RaisedButton1
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: signOut,
              child: new Text("Sign out"),
              color: Colors.red,
            ), // RaisedButton2
          ], //<Widget>[]
        ), // Column
      ), // Padding
    ); // Scaffold
  }

}


class FbDataEntry {
  String facedetected;
  String location;
  String souffle;
  String whoiam;



  FbDataEntry(this.facedetected,this.location, this.souffle, this.whoiam);

  toJson() {
    return {
      "facedetected": facedetected,
      "location": location,
      "souffle": souffle,
      "whoiam": whoiam
    };
  }

}

class SoufflePage extends StatefulWidget {
  SoufflePage({Key key, this.title}) :super(key: key);

  final String title;

  @override
  _SoufflePageState createState() => new _SoufflePageState();
}


class _SoufflePageState extends State <SoufflePage> {

  static TextEditingController _controller = new TextEditingController();
  final reference = FirebaseDatabase.instance.reference();




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Welcome To Souffle Page")),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: 'Type Souffle Here',
              ),
            ), //TextField
            new RaisedButton(
              onPressed: () { // This will update my db information
                FbDataEntry entry = new FbDataEntry(
                    "no","nolocation", _controller.text, "kullanıcı");
                reference.child('').set(entry.toJson());
              },
              child: new Text('Type your souffle here'),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
          ], //<Widget>[]
        ), // Column
      ), // Padding
    );
  }
}

