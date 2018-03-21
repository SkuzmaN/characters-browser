import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/mocks.dart' show characters;
import 'package:marvel_heroes/screens/character_details.dart';

class CharactersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.red,
      appBar: new AppBar(
        title: new Text('Marvel\'s characters'),
        backgroundColor: Colors.black,
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: new ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              return new ListTile(
                title: new Text(characters[index].name,
                style: new TextStyle(
                  color: Colors.white,
                ),),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new CharacterDetails(character: characters[index])));
                },
              );
            },
          )),
    );
  }
}