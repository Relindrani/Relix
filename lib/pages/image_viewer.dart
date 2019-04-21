import 'package:flutter/material.dart';

import 'dart:convert';

//*Page for showing full size image of item, tap again to close
class ImageViewer extends StatelessWidget{

  final String img;
  final bool isSteam;
  ImageViewer(this.img, this.isSteam);

  @override 
  Widget build(BuildContext context){
    return new Material(
      child: InkWell(
        child: (isSteam) ? Image.network(img) : Image.memory(base64.decode(img)),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}