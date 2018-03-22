import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:marvel_heroes/models/Character.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;

  CharacterDetails({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildHeader() {
      return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        margin: const EdgeInsets.symmetric(vertical: 24.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new CircleAvatar(
                  backgroundColor: Colors.red[700],
                  backgroundImage: new NetworkImage(character.thumbnail),
                ),
                width: 150.0,
                height: 150.0,
              ),
              new Container(
                margin: const EdgeInsets.only(top: 24.0),
                child: new Text(
                  character.name,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize:
                        Theme.of(context).primaryTextTheme.display1.fontSize,
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                child: new Text(
                  character.description,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildComicList() {
      return new Padding(
        padding: const EdgeInsets.all(24.0),
        child: new Column(
          children: character.comics
              .map((c) => new Column(
                    children: <Widget>[
                      new Divider(color: Colors.white),
                      new ListTile(
                        leading: const Icon(Icons.description),
                        title: new Text(c,
                            style: new TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ))
              .toList(),
        ),
      );
    }

    return new Scaffold(
      backgroundColor: Colors.red,
      appBar: new AppBar(
        title: new Text("Character Details"),
        backgroundColor: Colors.black,
      ),
      body: new SingleChildScrollView(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          new Divider(color: Colors.white),
          new Container(
            padding: const EdgeInsets.only(left: 24.0),
            margin: const EdgeInsets.only(top: 24.0),
            child: new Text(
              'Comics where this character appears:',
              textAlign: TextAlign.left,
              style: new TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).primaryTextTheme.title.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildComicList(),
        ],
      )),
    );
  }
}
