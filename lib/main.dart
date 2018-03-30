import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/model.dart';
import 'dart:io';
import 'dart:convert';
import 'package:logging/logging.dart';

void main() => runApp(new MyApp());
var httpClient = new HttpClient();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Rick and Morty',
      home: new RickAndMorty(),
    );
  }
}

class RickAndMorty extends StatefulWidget {
  @override
  createState() => new RickAndMortyState();
}

class RickAndMortyState extends State<RickAndMorty> {

  var modelList = <Model>[];
  final _customFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _getRickAndMortyCharacters();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Rick and Morty'),
      ),
      body: _buildListView()
    );
  }

  // setup single item in ListView
  Widget _buildRow(Model model) {
    return new ListTile(

      title: new Text(
        model.name,
        style: _customFont,
      ),

      leading: new CachedNetworkImage(
        imageUrl: model.imageUrl,
        placeholder: new CircularProgressIndicator(),
        errorWidget: new Icon(Icons.error),
      )


    );
  }

  // setup ListView
  Widget _buildListView(){

    return new ListView.builder(


        padding: const EdgeInsets.all(16.0),
        itemCount: modelList.length,
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();

          return _buildRow(modelList[i]);
        }
    );
  }

  // this function performs a network call to fetch rick and morty characters
  _getRickAndMortyCharacters() async {
    var url = 'https://rickandmortyapi.com/api/character';

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
    var _LOG = new Logger("R&M");

    var httpClient = new HttpClient();

    List<Model> result = <Model>[];
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);

        for (var k in data['results']) {
          var model = new Model();
          model.name = k['name'].toString();
          model.imageUrl = k['image'].toString();
          result.add(model);
        }

        httpClient.close();
      } else {
        _LOG.severe(response.statusCode);
        _LOG.severe(response);
      }
    } catch (exception) {
      _LOG.severe(exception);
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      modelList = result;
    });

  }


}



