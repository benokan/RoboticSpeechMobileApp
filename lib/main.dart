import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

// admin panelinde cevapları bilinmeyen sorular listelenecek oradan cevaplarını yazabileceğiz. Sufle verilebilir, kullanıcı adı söylenebilir,
// Gökhan'ın sorusu -> Bu paneli py ile değil de Web'de yazsak olur mu ?
//

//final FirebaseApp app = FirebaseApp(
//      options: FirebaseOptions(
//    googleAppID: '1:145247734917:android:49fe489faca05431',
//    apiKey: 'AIzaSyAZ8zAZRjKzdaygFwYa8e-jV5B-vGmnKgY',
//    databaseURL: 'https://robotic-speech.firebaseio.com',
//  ));


void main(){
  runApp(new MaterialApp(
    home: new MyHomePage(),
    routes: <String,WidgetBuilder>{
      "/SecondPage": (BuildContext context) => new SecondPage()
    }
  ));
}

class MyApp extends StatelessWidget{
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

class MyHomePage extends StatelessWidget {

  final FirebaseDatabase _fireBase = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();


  Future<FirebaseUser> signIn(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);
    print("User Name: ${user.displayName}");

    Navigator.of(context).pushNamed("/SecondPage");
    return user;
  }

  void signOut(){
    googleSignIn.signOut();
    print("User Signed out");
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title:new Text("Firebase Demo"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
            new RaisedButton( // button1 - SignIn
              onPressed:() => signIn(context)
                .then((FirebaseUser user) => print(user))
                .catchError((e) => print(e)),
              child: new Text("Sign in"),
              color: Colors.green,
            ),//RaisedButton1
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: signOut,
              child:new Text("Sign out"),
              color: Colors.red,
            ),// RaisedButton2
          ],//<Widget>[]
        ),// Column
      ), // Padding
    ); // Scaffold
  }

}


class FbDataEntry {
  String facedetected;
  String souffle;
  String whoiam;


  FbDataEntry(this.facedetected, this.souffle, this.whoiam);

  toJson() {
    return {
      "facedetected": facedetected,
      "souffle": souffle,
      "whoiam": whoiam
    };
  }

}


class SecondPage extends StatelessWidget {
  static TextEditingController _controller = new TextEditingController();
  FbDataEntry entry = new FbDataEntry("no", _controller.text, "kullanıcı");
  final reference = FirebaseDatabase.instance.reference();
  final mh = new MyHomePage();

  void x(){
    var a =reference.push().set(entry.toJson());
    print(a);
  }


  void _pushEdit(FbDataEntry ent) {
   reference.child('').set(ent.toJson());
  }

  @override

  Widget build(BuildContext context){
    return new Scaffold(
      appBar:new AppBar(title: new Text("Welcome To Souffle Page")),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
            new TextField(
              controller: _controller,
              decoration: new InputDecoration(
              hintText: 'Type Souffle Here',
              ),
            ),//TextField
            new RaisedButton(

                onPressed: () => _pushEdit(entry) // This will update my db information
              ,

              child: new Text('Type your souffle here'),
            ),

            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
          ],//<Widget>[]
        ),// Column
      ), // Padding
    );
  }
}

