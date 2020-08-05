import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Flutter layout',
      initialRoute: '/',
      routes: {
        '/': (buildContext) => HomeScreen(),
        '/second': (buildContext) => SecondScreen()
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

  Widget textSection = Container(
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
        textSection,
        FirstNavigationButton(),
      ]),
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
      ]),
    );
  }
}
