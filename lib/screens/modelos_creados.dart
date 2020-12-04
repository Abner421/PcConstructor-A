import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final User _user = FirebaseAuth.instance.currentUser;

class ModelosCreados extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModelosCreados();
}

class _ModelosCreados extends State<ModelosCreados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _db
                .collection('modelos')
                .where('uid', isEqualTo: _user.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text('No hay datos...');
              return ListView(children: getModelos(snapshot));
            }),
      ),
    );
  }

  getModelos(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((e) => new GFAccordion(
              contentBackgroundColor: Colors.grey[300],
              titleChild: Text(
                'ID de modelo: ' + e['modeloId'].toString(),
                style: TextStyle(color: Colors.white),
              ),
              contentChild: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Almacenamiento: ' + e['almacenamiento'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Fuente de poder: ' + e['fuentePoder'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Tarjeta gráfica: ' + e['graficas'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Tarjeta madre: ' + e['motherboard'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Procesador: ' + e['procesador'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Gabinete: ' + e['gabinete'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Enfriamiento gabinete: ' + e['coolerGabinete'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Enfriamiento CPU: ' + e['cpuCooler'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Memoria RAM: ' + e['ram'],
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Material(
                    color: Colors.grey[300],
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Color(0xffB593CC),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.picture_as_pdf),
                          color: Colors.white,
                          tooltip: 'Exportar PDF',
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              collapsedIcon: Text(
                'Mostrar',
                style: TextStyle(color: Colors.white),
              ),
              expandedIcon: Text(
                'Ocultar',
                style: TextStyle(color: Colors.white),
              ),
              collapsedTitleBackgroundColor: Color(0xff7B32D9),
              expandedTitleBackgroundColor: Color(0xffB593CC),
              titleBorderRadius: BorderRadius.circular(3),
            ))
        .toList();
  }
}
