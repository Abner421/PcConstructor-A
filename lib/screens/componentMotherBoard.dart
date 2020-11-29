import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class componentsMB extends StatefulWidget {
  final String comp;

  componentsMB({
    Key key,
    @required this.comp,
  });

  @override
  State<StatefulWidget> createState() {
    return new _componentsMB(componente: comp);
  }
}

class _componentsMB extends State<componentsMB> {
  final String componente;

  _componentsMB({
    Key key,
    @required this.componente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: Image.network(
                  "https://www.bhphotovideo.com/images/images2000x2000/amd_3990x_ryzen_threadripper_2_9_ghz_1538131.jpg",
                  height: 150,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
