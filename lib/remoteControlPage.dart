import 'package:flutter/material.dart';


class remoteControlPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(90.0),
      child: new Row(
        children: [
        ],
      ),
    );

    Widget upButton = new Container(

      child: new Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey),
              borderRadius: BorderRadius.zero


            ),
            child: new IconButton(
              icon: new Icon(Icons.rotate_left),
              onPressed: () => {}, // Functions will come here
              iconSize: 90.0,
              splashColor: Colors.blue,

            ),
          ),
          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey),
            ),
            child: new IconButton(
              icon: new Icon(Icons.keyboard_arrow_up),
              onPressed: () => {}, // Functions will come here
              iconSize: 90.0,
              splashColor: Colors.blue,

            ),
          ),

          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey),
            ),
            child: new IconButton(
              icon: new Icon(Icons.rotate_right),
              onPressed: () => {}, // Functions will come here
              iconSize: 90.0,
              splashColor: Colors.blue,
            ),
          )
        ],
      ),
    );

    Widget gap = new Container(
      padding: const EdgeInsets.all(5.0),
    );

    Widget middleButtons = new Container(

      child: new Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Container(
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.grey),
                borderRadius: BorderRadius.zero


            ),
            child: new IconButton(
              icon: new Icon(Icons.keyboard_arrow_left),
              onPressed: () => {}, // Functions will come here
              iconSize: 90.0,
              splashColor: Colors.blue,

            ),
          ),
          new Container(

            child: new IconButton(
              icon: new Icon(Icons.stop,color: Colors.white,),
              onPressed: null, // Functions will come here
              iconSize: 90.0,
            ),
          ),

          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey),
            ),
            child: new IconButton(
              icon: new Icon(Icons.keyboard_arrow_right),
              onPressed: () => {}, // Functions will come here
              iconSize: 90.0,
              splashColor: Colors.blue,
            ),
          )
        ],
      ),
    );

    Widget downButton = new Container(
      child: new Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

        new Container(
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey),
          ),
          child: new IconButton(icon: new Icon(Icons.keyboard_arrow_down),
              onPressed: () => {},
              iconSize: 90.0,
              splashColor: Colors.blue,
            ),
        )
        ],
      ),
    );


    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Remote Control Page'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: new ListView(

          children: [
            titleSection,
            upButton,
            gap,
            middleButtons,
            gap,
            downButton,
          ],
        ),
      ),
    );
  }

}




