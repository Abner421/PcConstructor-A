import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

addStringToSF(String modelo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('fuentePoder');
  prefs.setString('fuentePoder', modelo);
}

final FirebaseFirestore db = FirebaseFirestore.instance;

class ListFuentePoder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListFuentePoder();
}

class _ListFuentePoder extends State<ListFuentePoder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: getProcesadores(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.grey[500],
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ExpansionCard(
                            title: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.docs[index].data()['Marca'],
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.docs[index].data()['Modelo'],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 80, left: 25)),
                                        Text(
                                          'Poder: ' +
                                              snapshot.data.docs[index]
                                                  .data()['Poder']
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Text(
                                            'Eficiencia: ' +
                                                snapshot.data.docs[index]
                                                    .data()['Eficiencia']
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    Text(
                                        'Color: ' +
                                            snapshot.data.docs[index]
                                                .data()['Color']
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                    GFButton(
                                      text: 'Añadir componente',
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        print("Avance registrado");

                                        print("Añade componente...");
                                        addStringToSF(snapshot.data.docs[index]
                                            .data()['Modelo']
                                            .toString());
                                        print("...Compontente añadido");
                                        Alert(
                                          context: context,
                                          type: AlertType.success,
                                          title: "Componente añadido",
                                          desc:
                                              "El componente se ha añadido de manera exitosa",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              width: 120,
                                            )
                                          ],
                                        ).show();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No hay datos");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<QuerySnapshot> getProcesadores() {
    return db.collection('fuente_poder').get();
  }
}
