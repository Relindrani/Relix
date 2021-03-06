import 'package:flutter/material.dart';
import '../widgets/item_tile.dart';

import '../globals.dart' as globals;

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomePageState();
}

/**
 * *Home page after logging into app
 * *Displays 3 horizontally scrolling lists
 * *First checks if there are any items in the collection, if not displays text stating so
 * *Then displays 3 rows, one for recently viewed, one for recently added, and once for all items (to be changed later)
 * TODO: Change third row to something else
 */
class HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Center(
        child: (globals.items != null && globals.items.isNotEmpty) ? Container(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                flex: 3, 
                child: Text(
                  "Recently Viewed", 
                  style: TextStyle(
                    fontSize: 32.0
                  ), 
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 9,
                child: (globals.recentlyViewed != null && globals.recentlyViewed.isNotEmpty) ? GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemCount: globals.recentlyViewed.length,
                  itemBuilder: (context, index) => ItemTile(globals.recentlyViewed.elementAt(index)),
                ) : Container(height: 300, alignment: Alignment.center, child: Text("No items found")),
              ),
              Divider(),
              Flexible(
                flex: 3, 
                child: Text(
                  "Recently Added", 
                  style: TextStyle(
                    fontSize: 32.0
                  ), 
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 9,
                child: (globals.recentlyAdded != null && globals.recentlyAdded.isNotEmpty) ? GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemCount: globals.recentlyAdded.length,
                  itemBuilder: (context, index) => ItemTile(globals.recentlyAdded.elementAt(index)),
                ) : Container(height: 300, alignment: Alignment.center, child: Text("No items found")),
              ),
              Divider(),
              Flexible(
                flex: 3, 
                child: Text(
                  "All Items", 
                  style: TextStyle(
                    fontSize: 32.0
                  ), 
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 9,
                child: (globals.items != null && globals.items.isNotEmpty) ? GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                  itemCount: 10,
                  itemBuilder: (context, index) => ItemTile(globals.items[index]),
                ) : Container(height: 300, alignment: Alignment.center, child: Text("No items found"),),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0),)
            ],
          ),
        ) : Container (child: Text("No items found"),),
      )
    );
  }
}