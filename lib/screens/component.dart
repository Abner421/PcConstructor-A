import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class components extends StatefulWidget {
  final String comp;

  components({
    Key key,
    @required this.comp,
  });

  @override
  State<StatefulWidget> createState() {
    return new component(componente: comp);
  }
}

class component extends State<components> {
  List<List<dynamic>> data = [
    [
      {'componente': 'Procesador'},
    ]
  ];

  //Pantalla que mostrará los componentes que se pueden añadir
  final String componente;
  Color _iconColor = Colors.grey;

  component({
    Key key,
    @required this.componente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text(componente),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            GFCard(
              boxFit: BoxFit.cover,
              image: Image.network(
                "https://www.amd.com/system/files/24301-ryzen-3-pib-left-facing-1260x709_2.png",
                height: 100,
              ),
              title: GFListTile(
                title: Text(
                  'AMD Ryzen 3 1300X',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('4 núcleos\n3.7Ghz'),
                icon: IconButton(
                  icon: Icon(Icons.beenhere, color: _iconColor),
                  onPressed: () {
                    setState(() {
                      _iconColor = Colors.pinkAccent;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            GFCard(
              boxFit: BoxFit.fill,
              image: Image.network(
                "https://www.bhphotovideo.com/images/images1000x1000/amd_yd195xa8aewof_ryzen_threadripper_1950x_1354438.jpg",
                height: 100,
              ),
              title: GFListTile(
                title: Text(
                  'AMD Ryzen Threadripper 3990X',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('64 núcleos\n4.3Ghz'),
                icon: IconButton(
                  icon: Icon(Icons.beenhere, color: _iconColor),
                  onPressed: () {
                    setState(() {
                      _iconColor = Colors.pinkAccent;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            GFCard(
              boxFit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.red, BlendMode.hue),
              image: Image.network(
                "https://www.efecto2000.es/1855-large_default/procesador-intel-core-i5-7400.jpg",
                height: 100,
              ),
              title: GFListTile(
                title: Text(
                  'Intel Core i5 1160 7G',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('4 núcleos\n2.7Ghz'),
                icon: IconButton(
                  icon: Icon(Icons.beenhere, color: _iconColor),
                  onPressed: () {
                    setState(() {
                      _iconColor = Colors.pinkAccent;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            GFButton(
              onPressed: () {
                _firestore
                    .collection("procesadores")
                    .get()
                    .then((querySnapshot) {
                  querySnapshot.docs.forEach((result) {
                    print('Prueba BD');
                    print(result.data());
                    print(result.data()["Cores"]);
                    print(result.data()['Hilos']);
                    print('--- Fin prueba ---');
                  });
                });
              },
              text: 'Prueba',
            )
          ],
        ),
      ),
    );
  }
}
