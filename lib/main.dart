import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Flutter layout',
      initialRoute: '/',
      routes: {
        '/': (buildContext) => HomeScreen(),
        '/second': (buildContext) => SecondScreen(),
        '/third': (buildContext) => ThirdScreen()
      },
      theme: ThemeData.light(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  /// Create the button
  static Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }

  Widget buttonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
        _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
      ],
    ),
  );

  /// Create the title widget
  Widget titleWidget = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Purani Haveli!!!!!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text('Bangalore')
            ],
          ),
        ),
        Star()
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerParent(),
      appBar: AppBar(title: Text('App bar')),
      body: ListView(children: [
        Image.asset(
          'images/1.jpg',
          width: 600,
          height: 640,
          fit: BoxFit.cover,
        ),
        titleWidget,
        buttonSection,
        TextSection(),
        FirstNavigationButton(),
        DeleteDateSomewhere(),
        //Center(child: CircularProgressIndicator()),
      ]),
    );
  }
}

class TextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSnackBar(message: 'User tapped on the text!', context: context);
      },
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true,
        ),
      ),
    );
  }
}

class DrawerParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('Item 1'),
        )
      ],
    );
  }
}

class Star extends StatefulWidget {
  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  var likes = 12;
  bool isFavourite = false;

  void _onTap() {
    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text('Content clicked'),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    setState(() {
      if (isFavourite) {
        likes--;
        isFavourite = false;
      } else {
        likes++;
        isFavourite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(isFavourite ? Icons.star : Icons.star_border),
          color: Colors.red[500],
          onPressed: _onTap,
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$likes'),
          ),
        )
      ],
    );
  }
}

class FirstNavigationButton extends StatelessWidget {
  _navigateToSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );

    final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      content: Text('$result'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          child: Text('Navigate'),
          onPressed: () {
            _navigateToSecondScreen(context);
          }),
    );
  }
}

class SecondNavigationButton extends StatelessWidget {
  void _navigateToThirdScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThirdScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text('Go to tabs screen'),
        onPressed: () {
          _navigateToThirdScreen(context);
        },
      ),
    );
  }
}

class DeleteDateSomewhere extends StatelessWidget {
  Future<http.Response> deleteAlbum(String id, BuildContext context) async {
    final http.Response response = await http.delete(
      'https://jsonplaceholder.typicode.com/albums/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      showSnackBar(message: 'Successfully deleted', context: context);
    } else {
      showSnackBar(
          message: 'Failed to delete', context: context, durationInSeconds: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('Delete Something'),
          onPressed: () {
            deleteAlbum("1", context);
          },
        )
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second screen"),
      ),
      body: ListView(children: <Widget>[
        RaisedButton(
          child: Text('YES button'),
          onPressed: () {
            Navigator.pop(context, 'YES pressed!');
          },
        ),
        RaisedButton(
          child: Text('NO button'),
          onPressed: () {
            Navigator.pop(context, 'NO pressed!');
          },
        ),
        FetchAlbum(),
      ]),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_boat)),
                Tab(icon: Icon(Icons.directions_bus)),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back First screen'),
                ),
              ),
              Tab(icon: Icon(Icons.directions_boat)),
              Tab(icon: Icon(Icons.directions_bus)),
            ],
          ),
        ));
  }
}

class FetchAlbum extends StatefulWidget {
  @override
  _FetchAlbumState createState() => _FetchAlbumState();
}

class _FetchAlbumState extends State<FetchAlbum> {
  fetchJson(BuildContext context) async {
    final response = await http.get(
        'final response = http.get(https://jsonplaceholder.typicode.com/albums/100');
    if (response.statusCode == 200) {
      return json.decode(response.body)['UserId'].toString();
    } else {
      showSnackBar(message: 'Failed to to get the json', context: context);
      return "Failed to the get the response.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchJson(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

void showSnackBar(
    {@required String message,
    @required BuildContext context,
    int durationInSeconds}) {
  if (durationInSeconds == null) {
    durationInSeconds = 1;
  }
  final snackBar = SnackBar(
    duration: Duration(seconds: durationInSeconds),
    content: Text(message),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
