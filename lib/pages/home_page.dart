import 'package:flutter/material.dart';
import 'dart:async';

import '../services/authentication.dart';

class HomePage extends StatefulWidget{
  HomePage({Key key, this.auth, this.userId, this.onSignedOut});

  final BaseAuth auth;
  final String userId;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    return new Material(
      color: Colors.blueGrey,
      child: new InkWell(
        onTap: () => widget.onSignedOut()
      )
    );
  }
}