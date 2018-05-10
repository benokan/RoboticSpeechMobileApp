import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'main.dart';

// waitlocation'ı değiştirmek için ayrı bir buton yap...

class LocationPage extends StatefulWidget {

  @override
  LocationPageState createState() {
    return new LocationPageState();
  }

}

class LocationPageState extends State<LocationPage> {

  final reference = FirebaseDatabase.instance.reference();

  // Sufle variable to print


  // variables for creating the new dropdownButton
  String _value = null;
  List <String> _values = new List<String>();
  // to show in app only
  String temp=null ;

  void _onChanged(String value) {
    setState(() {
      _value = value;
      temp =_value;
    });

    FbDataEntryLocationOnly entry = new FbDataEntryLocationOnly(_value);
    reference.child('location').set(_value);
  }



  @override
  void initState() {
    _values.addAll(['location1', 'location2', 'location3','location4','location5','location6','location7','location8','locaiton9','nolocation']);
    _value = _values.elementAt(0);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Locations Page"),backgroundColor: Colors.deepOrangeAccent,),
        body: new Padding(padding: new EdgeInsets.all(2.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:new Image.asset('images/firebase.png',height: 100.0,width:200.0),
                ),
                new GestureDetector(
                  child: new Container(
                    child: new Center(


                      child:(temp==null) ?
                      new Text(
                        "Location you've sent to Firebase is\n\n Not initialized yet",
                        style: new TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepOrangeAccent,
                        ),
                        textAlign: TextAlign.center,

                      ) :  new Text(
                        "Location at Firebase is\n\n$temp",
                        style: new TextStyle(
                          fontSize: 24.0,
                          color: Colors.deepOrangeAccent,
                        ),
                        textAlign: TextAlign.center,

                      ),

                    ),
                    decoration: new BoxDecoration(
                      color: Colors.white12,
                    ),


                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new DropdownButton(
                    value: _value,
                    items: _values.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: new Row(
                          children: [
                            new Icon(Icons.send),
                            new Text('Templates:${value}'),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (String value) {
                      _onChanged(value);
                    },
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    padding: new EdgeInsets.all(20.0),
                    color: Colors.deepOrangeAccent,
                    onPressed: () {
                      FbDataEntry entry = new FbDataEntry(
                          "no", "nolocation", "sufle yok", "no", "kullanıcı");
                      reference.child('').set(entry.toJson());
                      setState((){
                        temp = "nolocation";
                      });
                    },

                    child: new Text("Set all to Default"),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(


                    padding: new EdgeInsets.all(20.0),
                    onPressed: () {
                      reference.child('waitlocation').set("yes");
                    },
                    child: new Text("Set waitlocation to yes"),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(


                    padding: new EdgeInsets.all(20.0),
                    onPressed: () {
                      reference.child('waitlocation').set("no");
                    },
                    child: new Text("Set waitlocation to no"),
                  ),
                ),


              ],

            )
        )
    );
  }
}



