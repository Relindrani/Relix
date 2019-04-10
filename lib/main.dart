import 'package:flutter/material.dart';

import 'pages/root_page.dart';
import 'services/authentication.dart';

void main() => runApp(Relix());

class Relix extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Relix",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: new RootPage(auth: new Auth())
    );
  }
}

//! STEAM API KEY: 384793BEC18B6C662319C44C7A28A5D7