import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marvel_heroes/features/characters/models/character.dart';
import 'package:marvel_heroes/features/characters/screens/details.dart';
import 'package:marvel_heroes/features/characters/screens/list.dart';


class MarvelCharacters extends StatefulWidget {
  @override
  _MasterDetailContainerState createState() =>
      new _MasterDetailContainerState();
}


class _MasterDetailContainerState extends State<MarvelCharacters> {
  static const int kTabletBreakpoint = 600;
  Character _selected;


  Widget _buildMobileLayout() {
    return new CharactersList(
        characterSelectedCallback: (character) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new CharacterDetails(
                    character: character,
                    isInTabletLayout: false,
                  )));
        });
  }

  Widget _buildEmptyState() {
    return new Center(
      child: new Text(
          "No character selected"
      ),
    );
  }

  Widget _buildTabletLayout() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          flex: 1,
          child: new Material(
            elevation: 8.0,
            shadowColor: Colors.red,
            child: new CharactersList(
              characterSelectedCallback: (item) {
                setState(() {
                  _selected = item;
                });
              },
              selected: _selected,
            ),
          ),
        ),
        new Flexible(
          flex: 3,
          child: _selected != null ? new CharacterDetails(
            key: new Key(_selected.id.toString()),
            character: _selected,
            isInTabletLayout: true,
          ) : _buildEmptyState(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Marvel characters'),
      ),
      body: new LayoutBuilder(
        builder: (context, constraints) {
          final double smallestDimension = min(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          if (smallestDimension < kTabletBreakpoint) {
            return _buildMobileLayout();
          }

          return _buildTabletLayout();
        },
      ),
    );
  }

}