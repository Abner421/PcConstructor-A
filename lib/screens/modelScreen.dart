import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:pc_constructor_a/my_flutter_app_icons.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pc_constructor_a/screens/listview_almacenamiento.dart';
import 'package:pc_constructor_a/screens/listview_coolerGabinete.dart';
import 'package:pc_constructor_a/screens/listview_cpuCooler.dart';
import 'package:pc_constructor_a/screens/listview_fuentePoder.dart';
import 'package:pc_constructor_a/screens/listview_gabinete.dart';
import 'package:pc_constructor_a/screens/listview_graficas.dart';
import 'package:pc_constructor_a/screens/listview_motherboard.dart';
import 'package:pc_constructor_a/screens/listview_procesador.dart';
import 'package:pc_constructor_a/screens/listview_ram.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listview_procesador.dart';

class modelScreen extends StatefulWidget {
  @override
  _modelScreenState createState() => _modelScreenState();
}

class _modelScreenState extends State<modelScreen> {
  getValuesAll(key) async {

    /*final SharedPreferences prefs = await _prefs;
    String jsonString = prefs.getString("$key");
    var _res = jsonDecode(jsonString);
    return _res;*/
  }


  List list = [
    "Intel",
    "AMD",
    "Ryzen",
    "i5",
  ];

  final String nombreComponente;
  int _currentValue = 0;

  establecerValor(int value) {
    setState(() {
      _currentValue = value;
    });
  }

  _modelScreenState({this.nombreComponente});

  Future<bool> compatibles() async {
    bool compat;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return string
    String socket_procesador = prefs.getString('Procesador');
    String socket_motherboard = prefs.getString('Motherboard');

    prefs.containsKey('Procesador')
        ? print('El socket de procesador es: ' + socket_procesador)
        : print('No hay socket en procesador');

    prefs.containsKey('Motherboard')
        ? print('El socket de motherboard es: ' + socket_motherboard)
        : print('No hay socket en motherboard');

    (socket_procesador == socket_motherboard) ? compat = true : compat = false;

    return compat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text('Nuevo modelo'),
        centerTitle: true,
      ),
      body: Container(
        decoration: new BoxDecoration(
            //Gradiente de fondo
            gradient: LinearGradient(
          colors: [Color(0xff0093E9), Color(0xff80D0C7)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
        margin: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
        child: ListView(
          padding: EdgeInsets.all(12.5),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            GFButton(
              text: 'Prueba compatibilidad',
              onPressed: () async {
                final SharedPreferences _prefs = await SharedPreferences.getInstance();
                List<String> claves = _prefs.getKeys().toList(growable: true);
                print(claves);
                for(int i=0;i<claves.length;i++){
                  print(_prefs.get(claves[i].toString()));
                }

                await compatibles()
                    ? showDialog(
                        context: context,
                        builder: (_) => AssetGiffyDialog(
                              title: Text(
                                'Compatibles',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              description: Text(
                                'Los componentes son compatibles',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              image: Image.asset(
                                'assets/gif/giphy_ok.gif',
                                fit: BoxFit.contain,
                              ),
                              entryAnimation: EntryAnimation.DEFAULT,
                              onlyOkButton: true,
                              onOkButtonPressed: () {
                                Navigator.pop(context);
                              },
                            ))
                    : showDialog(
                        context: context,
                        builder: (_) => AssetGiffyDialog(
                              title: Text(
                                'No Compatibles',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              description: Text(
                                'Los componentes no son compatibles',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              image: Image.asset(
                                'assets/gif/giphy_error.gif',
                                fit: BoxFit.fill,
                              ),
                              entryAnimation: EntryAnimation.DEFAULT,
                              onlyOkButton: true,
                              onOkButtonPressed: () {
                                Navigator.pop(context);
                              },
                            ));
              },
            ),
            GFSearchBar(
              searchList: list,
              searchQueryBuilder: (query, list) {
                return list
                    .where((item) =>
                        item.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
              overlaySearchListItemBuilder: (item) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
              onItemSelected: (item) {
                setState() {
                  print('$item');
                }
              },
            ),
            FAProgressBar(
              currentValue: _currentValue,
              maxValue: 100,
              size: 25,
              changeProgressColor: Colors.teal,
              progressColor: Colors.lightGreenAccent,
              displayText: '%',
              animatedDuration: const Duration(milliseconds: 1000),
            ),
            GFTypography(
              text: 'Componentes',
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.select_all),
                title: Text('Procesador'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () async {
                  establecerValor(11);
                  Navigator.of(context).push(MaterialPageRoute(
                    //builder: (context) => components(comp: 'Procesador'),
                    builder: (context) => ListProcesador(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.blur_linear),
                title: Text('Tarjeta madre'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(25);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListMotherboard(),
                  ));
                },
              ),
              elevation: 3,
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.ac_unit),
                title: Text('Enfriamiento CPU'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(27);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListCoolerCPU(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(MyFlutterApp.icons8_workstation_24),
                title: Text('Gabinete'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(39);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListGabinete(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.card_membership),
                title: Text('Tarjeta gráfica'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(51);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListGraficas(),
                  ));
                  GFProgressBar(
                    percentage: 0.4,
                    animation: true,
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.compare_arrows),
                title: Text('Enfriamiento gabinete'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(63);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListCoolerGabinete(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.memory),
                title: Text('Memoria RAM'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(75);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListRAM(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.storage),
                title: Text('Almacenamiento'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(87);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListAlmacenamiento(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.flash_on),
                title: Text('Fuente de poder'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor(100);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListFuentePoder(),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
