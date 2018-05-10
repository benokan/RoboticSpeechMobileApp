import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

// border koy remote control + koydum da sanki biraz iğrenç oldu.

// şablon yerlerini listView'e çevir
// hangisnin db'da seçili olduğu belli olsun
// Selected unselected şeklinde olabilir.

// sahibin ismini değiştirme bu sayfa üzerinden yapılacak
// -> Setowner,getowner ceyda komutları
// delete owner da burada yapılacak
// sistemde kötü söz var mı onu göreceğiz buradan
// getangry , deleteangry
// setowner tarafına bir listview(şablon) ile kullanıcı isimlerini direk eşitleme yapacağız.

var codeToCeyda="selam";

Future <Post> botConnection() async {
  String url = "http://beta.ceyd-a.com/jsonengine.jsp";

  var headers = {
    'Accept': 'application/x-www-form-urlencoded',
    'Location': '/jsonengine.jsp'
  };


  var values =
  {"username": "gokhantok",
    "token": "57afc561f880eb8bfcbdf61821ea8626",
    "code": codeToCeyda};


  var response = await http.post(
      Uri.encodeFull(url), body: values, headers: headers, encoding: utf8);

  var Bodify = response.body;

  Bodify = Bodify.substring(1, Bodify.length - 3);

  var responseJson = json.decode(Bodify);


  return new Post.fromJson(responseJson);
}

Future <Post> getOwnerQuery() async {
  String url = "http://beta.ceyd-a.com/jsonengine.jsp";

  var headers = {
    'Accept': 'application/x-www-form-urlencoded',
    'Location': '/jsonengine.jsp'
  };


  var values =
  {"username": "gokhantok",
    "token": "57afc561f880eb8bfcbdf61821ea8626",
    "code": "beni tanıyor musun?"};


  var response = await http.post(
      Uri.encodeFull(url), body: values, headers: headers, encoding: utf8);

  var Bodify = response.body;

  Bodify = Bodify.substring(1, Bodify.length - 3);

  var responseJson = json.decode(Bodify);


  return new Post.fromJson(responseJson);
}

Future <Post> getAngryWordQuery() async {
  String url = "http://beta.ceyd-a.com/jsonengine.jsp";

  var headers = {
    'Accept': 'application/x-www-form-urlencoded',
    'Location': '/jsonengine.jsp'
  };


  var values =
  {"username": "gokhantok",
    "token": "57afc561f880eb8bfcbdf61821ea8626",
    "code": "Bana küs müsün?"};


  var response = await http.post(
      Uri.encodeFull(url), body: values, headers: headers, encoding: utf8);

  var Bodify = response.body;

  Bodify = Bodify.substring(1, Bodify.length - 3);

  var responseJson = json.decode(Bodify);


  return new Post.fromJson(responseJson);
}


class Post {
  String question;
  String answer;
  String username;

  Post({this.question, this.answer, this.username});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      question: json['question'],
      answer: json['answer'],
      username: json['username'],
    );
  }
}

void main() => runApp(new Ceyda());

class Ceyda extends StatefulWidget {


  @override
  CeydaState createState() {
    return new CeydaState();
  }



}

class CeydaState extends State<Ceyda> {
  static TextEditingController _controller = new TextEditingController();


  void refresh() {
    setState(() {
      return new CeydaState();
    });
  }

  void d_angry() {
    // will delete angry word on ceyd-a
    codeToCeyda = "deletebadsentence";
    botConnection();
    refresh();
  }

  void getAngry() {
    // will check if there's an angry word or not
    codeToCeyda = "Bana küs müsün?";
    botConnection();
  }

  void set_owner(TextEditingController controllerInput) {
    codeToCeyda = "benim adım " + controllerInput.text;
    print(codeToCeyda);
    botConnection();
    new Future.delayed(const Duration(seconds:2),()=>"2"); // must wait a bit to set $SAHİBİNADİ parameter in ceyd-a server-side
    refresh();

  }

  void getOwner() {
    codeToCeyda = "Ben kimim?";
     botConnection();

  }

  void d_owner() {
    // delete owner name
    codeToCeyda = "deleteownername";
    botConnection();
    new Future.delayed(const Duration(seconds:2),()=>"2"); // must wait a bit to set $SAHİBİNADİ parameter in ceyd-a server-side
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    Widget setOwner = new Container(
      // ListView ile direk eşitleme yapılacak buradan
        padding: const EdgeInsets.all(20.0),
        child: new Column(

          children: <Widget>[
            new Container(
              child: new TextField(
                controller: _controller,
                decoration: new InputDecoration(
                  hintText: 'Type Owner Name',
                ),
              ),

            ),
            new RaisedButton( // sadece sufleyi değiştirecek şekilde düzenlendi +
              onPressed: () { // This will update my db information
                print(_controller);
                set_owner(_controller);
                print(_controller);
              },
              child: new Text('Set Owner Name'),
            ),
          ],
        )

    );


    Widget getOwner = new Container(
      padding: const EdgeInsets.all(21.0),
      child: new FutureBuilder<Post>(
        future: getOwnerQuery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Text("Current User: " + snapshot.data.answer,style: new TextStyle(color: Colors.deepOrangeAccent,fontSize: 20.0),);
          } else if (snapshot.hasError) {
            return new Text("waiting for response");
          }

          return new LinearProgressIndicator(backgroundColor: Colors.deepOrangeAccent);
        },

      ),

    );


    Widget deleteOwner = new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Column(

          children: <Widget>[
            new Container(
              child: new RaisedButton(
                  onPressed: d_owner,
                  child: new Text("Delete owner name")
              ),
            )
          ],
        )
    );


    Widget getAngry = new Container(
      padding: const EdgeInsets.all(20.0),
      child: new FutureBuilder<Post>(
        future: getAngryWordQuery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Text("Angry Word: " + snapshot.data.answer,style: new TextStyle(color: Colors.deepOrangeAccent,fontSize: 20.0),);
          } else if (snapshot.hasError) {
            return new Text("waiting for response");
          }

          return new LinearProgressIndicator(backgroundColor: Colors.deepOrangeAccent);
        },

      ),
    );


    Widget deleteAngry = new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Column(

          children: <Widget>[
            new Container(
              child: new RaisedButton(
                  onPressed: d_angry,
                  child: new Text("Delete angry word")
              ),
            )
          ],
        )
    );

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ceyda',
      theme: new ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Ceyda Controller'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: new ListView(

          children: [ // Put related ceyd-a widgets there
            new Image.asset('images/ceyd-a.png',height: 100.0,width:200.0),
            deleteOwner,
            deleteAngry,
            setOwner,
            getOwner,
            getAngry,
          ],
        ),
      ),
    );
  }
}

