import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

  Widget _buttonSection = Container(
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
  Widget _titleWidget = Container(
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

  Widget _textSection = Container(
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
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Flutter layout',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test app'),
          ),
          body: ListView(
            children: <Widget>[
              Image.asset(
                'images/1.jpg',
                width: 600,
                height: 640,
                fit: BoxFit.cover,
              ),
              _titleWidget,
              _buttonSection,
              _textSection,
            ],
          )),
      theme: ThemeData.light(),
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
