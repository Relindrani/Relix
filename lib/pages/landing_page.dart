import 'package:flutter/material.dart';

import '../services/authentication.dart';

import '../models/steam_item.dart';

import '../pages/home_page.dart';
import '../pages/category_view_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
class LandingPage extends StatefulWidget{
  LandingPage({Key key, this.auth, this.userId, this.onSignedOut});

  final BaseAuth auth;
  final String userId;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin{

  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new TabBarView(
        children: <Widget>[new HomePage(), new CategoryViewPage(), new SearchPage(), new SettingsPage(userId: widget.userId, auth: widget.auth, onSignedOut: widget.onSignedOut,)],
        controller: controller,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            
        },
        tooltip: 'New Item',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
        child: new TabBar(
          labelColor: Colors.deepOrangeAccent,
          unselectedLabelColor: Colors.white,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.home)),
            new Tab(icon: new Icon(Icons.view_module)),
            new Tab(icon: new Icon(Icons.search)),
            new Tab(icon: new Icon(Icons.settings))
          ],
          controller: controller,
        ),
      ),
    );
  }
}

/**
 * ?Call API request on button press
        RaisedButton(
          onPressed: (){
            fetchPost().then((result) {
                print('In Builder');
            })
          },
          child: Text('Get data'),
        )

        RaisedButton(
          onPressed: () async {
            var result = await fetchPost()
            print('In Builder');
          },
          child: Text('Get data'),
        )
 */