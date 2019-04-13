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

//! STEAM API KEY: Key: 8BCD4971534B22531611F207DEA0FD47
//! STEAM PROFILE ID: 76561198067155644