import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'welcomePage.dart';
import 'remoteControlPage.dart';
import 'LocationPage.dart';
import 'Ceyda.dart';
import 'PlayGround.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        "/WelcomePage": (BuildContext context) => new welcomePage(),
        "/SoufflePage": (BuildContext context) => new SoufflePage(),
        "/RemoteControlPage": (BuildContext context) => new remoteControlPage(),
        "/HomePage": (BuildContext context) => new MyHomePage(),
        "/LocationsPage": (BuildContext context) => new LocationPage(),
        "/Ceyda": (BuildContext context) => new Ceyda(),
        "/PlayGround": (BuildContext context) => new PlayGround(),
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

        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(),
    );
  }
}

class FbDataEntry {
  String facedetected;
  String location;
  String souffle;
  String waitlocation;
  String whoiam;


  FbDataEntry(this.facedetected, this.location, this.souffle, this.waitlocation,
      this.whoiam);

  toJson() {
    return {
      "facedetected": facedetected,
      "location": location,
      "souffle": souffle,
      "waitlocation": waitlocation,
      "whoiam": whoiam
    };
  }

}

class FbDataEntryLocationOnly {
  String location;

  FbDataEntryLocationOnly(this.location);

  toJson() {
    return {
      "location": location,
    };
  }
}

class FbDataEntryFaceDetectedOnly {
  String facedetected;

  FbDataEntryFaceDetectedOnly(this.facedetected);

  toJson() {
    return {
      "facedetected": facedetected,
    };
  }
}

class FbDataEntrySouffleOnly {
  String souffle;

  FbDataEntrySouffleOnly(this.souffle);

  toJson() {
    return {
      "souffle": souffle,
    };
  }
}

class FbDataEntryWaitLocationOnly {
  String waitlocation;

  FbDataEntryWaitLocationOnly(this.waitlocation);

  toJson() {
    return {
      "waitlocation": waitlocation,
    };
  }
}

class FbDataEntryWhoIAmOnly {
  String whoiam;

  FbDataEntryWhoIAmOnly(this.whoiam);

  toJson() {
    return {
      "whoiam": whoiam,
    };
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) :super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State <MyHomePage> {


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
        title: new Text("Robotic Control Application"),
        backgroundColor: Colors.deepOrangeAccent,

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
              color: Colors.deepOrangeAccent,
            ), //RaisedButton1
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: signOut,
              child: new Text("Sign out"),
              color: Colors.grey,
            ), // RaisedButton2
          ], //<Widget>[]
        ), // Column
      ), // Padding
    ); // Scaffold
  }

}


class SoufflePage extends StatefulWidget {
  SoufflePage({Key key, this.title}) :super(key: key);

  final String title;

  @override
  @override
  _SoufflePageState createState() => new _SoufflePageState();
}

// State of SoufflePage
class _SoufflePageState extends State <SoufflePage> {

  String _value = null;
  List <String> _values = new List<String>();
  String souffle;
  String temp =null;

  @override
  void initState() {
    _values.addAll([
      'Hayır bunu bilmiyorum', 'Başka soru sor bana', 'Yaşasın Mütevelli Heyeti']);
    _value = _values.elementAt(0);
  }


  static TextEditingController _controller = new TextEditingController();
  final reference = FirebaseDatabase.instance.reference();

  void _onChanged(String value) {
    setState(() {
      _value = value;
      temp =_value;
    });



    FbDataEntrySouffleOnly entry = new FbDataEntrySouffleOnly(_value);
    reference.child('souffle').set(_value);

  }




  @override
  Widget build(BuildContext context) {

    Widget myInitSouffleWidget = new Container(
      child: new StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child('souffle')
            .onValue,
        builder: (BuildContext context, AsyncSnapshot<Event> event) {
          if (!event.hasData)
            return new Center(child: new Text('Loading...'));
          String souffle = event.data.snapshot.value;
          return new Center(
              child: new Text(
                "Souffle at the firebase now : " + souffle,
                style: new TextStyle(
                  fontSize: 24.0,
                  color: Colors.deepOrangeAccent,
                ),
                textAlign: TextAlign.center,
              )
          );
        },

      ),
    );

    Widget myImage = new Image.asset(
        'images/firebase.png',
        height: 125.0,
        width:200.0,


    );

    Widget gap = new Container(
      padding: const EdgeInsets.all(5.0),
    );

    Widget myText = new Container(
      child: new Center(
          child:(temp==null) ?

          myInitSouffleWidget :  new Text(
            "Souffle at Firebase is\n\n$temp",
            style: new TextStyle(
              fontSize: 24.0,
              color: Colors.deepOrangeAccent,
            ),
            textAlign: TextAlign.center,

          )
      ),
      decoration: new BoxDecoration(
        color: Colors.white12,
      ),




    );

    Widget myTemplates = new DropdownButton(
      value: _value,
      items: _values.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: new Row(
            children: [
              new Icon(Icons.send),
              new Text('Templates:${value}')
            ],
          ),
        );
      }).toList(),

      onChanged: (String value) {_onChanged(value);},
    );

    Widget textField = new TextField(

      onSubmitted: (String str){
        setState((){

        });
      },
      controller: _controller,
      decoration: new InputDecoration(
        hintText: 'Type Souffle Here',
      ),
    );

    Widget souffleSubmit = new RaisedButton( // sadece sufleyi değiştirecek şekilde düzenlendi +
      onPressed: () { // This will update my db information
        reference.child('souffle').set(_controller.text);

        setState((){
          temp = _controller.text;
        });


      },
      child: new Text('Type your souffle here'),
    );

    Widget setDefault = new RaisedButton( // sadece sufleyi eski haline döndürecek şekilde düzenlendi +

      onPressed: (){

        reference.child('souffle').set("sufle yok");
        setState((){
          temp = "sufle yok";
        });

      },
      child: new Text("Set Souffle to Default"),
    );






     return new MaterialApp(

       debugShowCheckedModeBanner: false,

       theme: new ThemeData(
         primarySwatch: Colors.blue,

       ),
       home: new Scaffold(
        appBar: new AppBar(
            title: new Text("Welcome To Souffle Page"),
            backgroundColor:Colors.deepOrangeAccent
        ),
        body: new ListView(
          children:[
            gap,
            gap,
            myImage,
            myText,
            myTemplates,
            textField,
            souffleSubmit,
            gap,
            setDefault,
          ]
        ), // ListView
    ),
     );
  }
}

