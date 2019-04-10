import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() => runApp(Relix());

class Relix extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Relix",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: LoginPage()
    );
  }
}