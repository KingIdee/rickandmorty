import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/model.dart';
import 'package:rick_and_morty/model_classes.dart';
import 'dart:io';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:rick_and_morty/result.dart';

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

  //var _rickAndMortyList = <Result>[];
  //var _rickAndMortyListString = <String>[];
  var modelList = <Model>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  int i=0;


  @override
  Widget build(BuildContext context) {

    /*new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Your current IP address is:'),
            new Text('$_ipAddress.'),
            spacer,
            new RaisedButton(
              onPressed: _getIPAddress,
              child: new Text('Get IP address'),
            ),
          ],
        ),
      ),
    );*/

    if (i==0) {
      _getRickAndMortyCharacters();
      i++;
    }
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
        style: _biggerFont,
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

    //_rickAndMortyListString.add("Hate!");
    //_rickAndMortyListString.add("HateII!");
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: modelList.length,
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row.
        // For even rows, the function adds a ListTile row for the word pairing.
        // For odd rows, the function adds a Divider widget to visually
        // separate the entries. Note that the divider may be difficult
        // to see on smaller devices.
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();

          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings in the ListView,
          // minus the divider widgets.
          final index = i / 2;
          //final index = i ~/ 2;
          // If you've reached the end of the available word pairings...
          /*if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }*/
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

    List<Result> result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        result = data['results'];

        for (var k in data['results']) {
          var model = new Model();
          model.name = k['name'].toString();
          model.imageUrl = k['image'].toString();
          modelList.add(model);
        }

      } else {
        _LOG.severe("Network issues");
      }
    } catch (exception) {
      _LOG.severe(exception);
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      //_rickAndMortyList = result;
    });

  }


}



