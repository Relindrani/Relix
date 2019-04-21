import 'package:flutter/material.dart';

import 'pages/root_page.dart';
import 'services/authentication.dart';

void main() => runApp(Relix());

//*Main class for launching app
class Relix extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Relix",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        splashColor: Colors.transparent
      ),
      home: new RootPage(auth: new Auth())
    );
  }
}

//! STEAM API KEY: Key: 8BCD4971534B22531611F207DEA0FD47
//! STEAM PROFILE ID: 76561198067155644

/**
 * ?Color theme
 * TODO:Fix across entire app
 * *Color.fromARGB(150, 56, 4, 84) (purple)
 * *Color.fromARGB(255, 126, 0, 0) (red)
 * *Color.fromARGB(255, 0, 153, 153) (green)
 */