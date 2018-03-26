import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_heroes/features/characters/models/character.dart';
import 'package:marvel_heroes/features/characters/services/character.dart'
    as CharacterService;
import 'package:meta/meta.dart';

class CharactersList extends StatefulWidget {
  @override
  createState() => new CharacterListState();

  CharactersList({@required this.characterSelectedCallback, this.selected});

  final ValueChanged<Character> characterSelectedCallback;
  final Character selected;
}

class CharacterListState extends State<CharactersList> {
  final int _limit = 20;
  final double _fetchBeforeEndOffset = 50.0;
  List<Character> _characters = [];
  bool _isMore = true;
  bool _fetching = true;
  bool _initialized = false;
  bool _error = false;
  int _page = 1;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData().whenComplete(() {
      this.setState(() {
        _initialized = true;
      });
    });
  }

  Future _fetchData() {
    return CharacterService.fetchAll(_page, _limit).then((response) {
      this.setState(() {
        _characters.addAll(response.data);
        _isMore = response.hasMore;
        _fetching = false;
        _page += 1;
        _error = false;
      });
    }).catchError((_) {
      this.setState(() {
        _fetching = false;
        _error = true;
      });
    });
  }

  Widget _buildError() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Text(
            'Some error appears',
            style: Theme.of(context).textTheme.body1,
          ),
          margin: const EdgeInsets.only(bottom: 8.0),
        ),
        _fetching
            ? new CircularProgressIndicator()
            : new RaisedButton(
                onPressed: () {
                  this.setState(() {
                    _fetching = true;
                  });
                  _fetchData();
                },
                child: new Text('Retry fetch data')),
      ],
    );
  }

  Widget _buildList() {
    return new ListView.builder(
      controller: _controller,
      itemCount:
      _fetching || _error ? _characters.length + 1 : _characters.length,
      itemBuilder: (context, index) {
        if (index >= _characters.length) {
          if (_fetching) {
            return new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Center(child: new CircularProgressIndicator()),
                  padding: const EdgeInsets.all(8.0),
                )
              ],
            );
          }
          return new Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildError(),
          );
        }
        return new ListTile(
          leading: new Container(
            child: new CircleAvatar(
              backgroundImage: new NetworkImage(_characters[index].thumbnail),
            ),
          ),
          title: new Text(
            _characters[index].name,
            style: Theme.of(context).textTheme.body1,
          ),
          onTap: () => widget.characterSelectedCallback(_characters[index]),
          selected: widget.selected == _characters[index],
        );
      },
    );
  }

  Widget _buildContent() {
    if (_fetching && !_initialized) {
      return new CircularProgressIndicator();
    }
    if (_error && _characters.length == 0) {
      return _buildError();
    }
    return _buildList();
  }

  @override
  Widget build(BuildContext context) {

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent <= _controller.offset + _fetchBeforeEndOffset) {
        if (!_fetching && _isMore) {
          this.setState(() {
            _fetching = true;
          });
          _fetchData();
        }
      }
    });

    return new Scaffold(body: new Center(child: _buildContent()));
  }
}
