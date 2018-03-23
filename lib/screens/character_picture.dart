import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterPicture extends StatelessWidget {
  final String image;
  final String name;

  CharacterPicture(this.image,this.name);

  @override
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          title: new Text(name),
          backgroundColor: Colors.red,
        ),
        body: new Center(
          child: new Hero(
            tag: 'character-image',
            child: new CachedNetworkImage(
              placeholder: new CircularProgressIndicator(),
              imageUrl: image,
            ),
          ),
        )
    );
  }
}