import 'package:flutter/material.dart';

import 'dart:convert';

class ImageViewer extends StatelessWidget{

  final String img;
  ImageViewer(this.img);

  @override 
  Widget build(BuildContext context){
    return new Material(
      child: InkWell(
        child: Image.memory(base64.decode(img)),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}