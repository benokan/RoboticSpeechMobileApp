import 'package:flutter/material.dart';



class remoteControlPage extends StatelessWidget {


  @override
    Widget build(BuildContext context) {
      Widget titleSection = new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Row(
          children: [
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  new Text("ms")

                ],
              ),
            ),

          ],
        ),
      );

      Widget upButton = new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new IconButton(
              icon: new Icon(Icons.keyboard_arrow_up),
              onPressed: null, // Functions will come here
              iconSize: 70.0,
            )
          ],
        ),
      );

      Widget middleButtons = new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new IconButton(icon: new Icon(Icons.keyboard_arrow_left),
                onPressed: null,
                iconSize: 70.0,
                padding: new EdgeInsets.only(right: 40.0)),
            new IconButton(icon: new Icon(Icons.keyboard_arrow_right),
                onPressed: null,
                iconSize: 70.0,
                padding: new EdgeInsets.only(left: 40.0))
          ],
        ),
      );

      Widget downButton = new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new IconButton(icon: new Icon(Icons.keyboard_arrow_down),
              onPressed: null,
              iconSize: 70.0,
            )
          ],
        ),
      );


      return new MaterialApp(
        title: 'Flutter Demo',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Remote Control Page'),
          ),
          body: new ListView(

            children: [
              titleSection,
              upButton,
              middleButtons,
              downButton,
            ],
          ),
        ),
      );
    }

  }




