import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:firebase_database/firebase_database.dart';

import '../services/authentication.dart';

import '../models/item.dart';
import '../models/itemTypes.dart';

import '../pages/home_page.dart';
import '../pages/category_view_page.dart';
import '../pages/search_page.dart';
import '../pages/settings_page.dart';
import '../pages/add_new_item_page.dart';

import '../services/database_handler.dart';

import '../globals.dart' as globals;

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

class LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin{

  DatabaseHandler _handler = new DatabaseHandler();

  TabController controller;
  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 4, vsync: this);
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
    
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new TabBarView(
        children: <Widget>[new HomePage(), new CategoryViewPage(), new SearchPage(), new SettingsPage(auth: widget.auth, onSignedOut: widget.onSignedOut,)],
        controller: controller,
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
}