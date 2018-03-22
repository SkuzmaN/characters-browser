import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/Character.dart';
import 'package:marvel_heroes/screens/character_details.dart';
import 'package:marvel_heroes/services/api.dart' show fetchCharacters;

class CharactersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text('Marvel\'s characters'),
        backgroundColor: Colors.red,
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: new FutureBuilder<List<Character>>(
            future: fetchCharacters(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new ListTile(
                      title: new Text(snapshot.data[index].name,
                        style: new TextStyle(
                          color: Colors.white,
                        ),),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                new CharacterDetails(character: snapshot.data[index])));
                      },
                    );
                  },
                );
              }else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new CircularProgressIndicator(backgroundColor: Colors.white,);
            },
          )),
    );
  }
}