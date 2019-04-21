import 'package:flutter/material.dart';

import '../services/authentication.dart';

import '../pages/home_page.dart';
import '../pages/category_view_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/add_new_item_page.dart';

import '../services/database_handler.dart';

import '../globals.dart' as globals;

//*Landing page of app after login, takes auth info to pass to settings page
class LandingPage extends StatefulWidget{
  LandingPage({Key key, this.auth, this.userId, this.onSignedOut}){
    globals.userId = userId;
  }

  final BaseAuth auth;
  final String userId;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new LandingPageState();
}

/**
 * *Landing page for initializing app
 * *Defines tab bar at bottom for switching pages
 * *Loads database information on start
 * *Loads different pages from tab bar using tab controller
 */
class LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin{

  DatabaseHandler _handler = new DatabaseHandler();

  bool _isLoading = false;

  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 4, vsync: this);
    _isLoading = true;
    start();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  void start() async{
    await _handler.loadDataBase().then((result){
      setState(() {
        globals.items = result; 
      });
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          new TabBarView(
            children: <Widget>[new HomePage(), new CategoryViewPage(), new SearchPage(), new SettingsPage(auth: widget.auth, onSignedOut: widget.onSignedOut,)],
            controller: controller,
          ),
          _showCircularProgress()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewItemPage())),
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

  Widget _showCircularProgress(){
    return _isLoading ? Center(child: CircularProgressIndicator()) : Container();
  }
}