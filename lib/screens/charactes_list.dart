import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/screens/character_details.dart';
import 'package:marvel_heroes/services/api.dart' show fetchCharacters;


class CharactersList extends StatefulWidget {
  @override
  createState() => new CharacterListState();
}

class CharacterListState extends State<CharactersList> {
  List<Character> _characters = [];
  bool _isMore = true;
  bool _fetching = true;
  int _page = 1;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    fetchCharacters(_page, _limit).then((response) {
      this.setState(() {
        _characters.addAll(response.data);
        _isMore = response.hasMore;
        _fetching = false;
        _page += 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent <= _controller.offset + 50.0) {
        if (!_fetching && _isMore) {
          this.setState(() {
            _fetching = true;
          });
          _fetchData();
        }
      }
    });

    Widget _renderList() {
      return new ListView.builder(
        controller: _controller,
        itemCount: _fetching ? _characters.length + 1 : _characters.length,
        itemBuilder: (context, index) {
          if (index >= _characters.length) {
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
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new CharacterDetails(character: _characters[index])));
            },
          );
        },
      );
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Marvel\'s characters'),
        ),
        body: new Center(
            child: _fetching && _page == 1
                ? new CircularProgressIndicator()
                : _renderList()));
  }
}
