import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:pc_constructor_a/servs/firestore_services.dart';
import 'package:pc_constructor_a/model/modelo.dart';

import 'listview_procesador.dart';

class modelScreen extends StatefulWidget {
  @override
  _modelScreenState createState() => _modelScreenState();
}

class _modelScreenState extends State<modelScreen> {
  getValuesAll(key) async {}
  List<bool> check = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  String almacenamiento;
  String coolerGabinete;
  String cpuCooler;
  String fuentePoder;
  String gabinete;
  String graficas;
  String motherboard;
  String procesador;
  String ram;

  FirestoreService _firestoreService;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _db = FirebaseFirestore.instance.collection('modelos');

  final String nombreComponente;
  int _currentValue = 0;

  establecerValor() {
    setState(() {
      _currentValue = _currentValue + 13;
    });
  }

  _modelScreenState({this.nombreComponente});

  Future<bool> compatibles() async {
    bool compat;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs);
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

  Future<bool> compPresente() async {
    bool existe;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("----------" + prefs.toString() + "\n-------------");
    prefs.containsKey('Motherboard') ? existe = true : existe = false;

    return existe;
  }

  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
              text: 'Guardar modelo',
              color: Color(0xff9a67f5),
              onPressed: () async {
                final SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                List<String> claves = _prefs.getKeys().toList(growable: true);
                print(claves);
                for (int i = 0; i < claves.length; i++) {
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
                              onOkButtonPressed: () async {
                                procesador = _prefs.get(claves[1]);
                                motherboard = _prefs.get(claves[2]);
                                cpuCooler = _prefs.get(claves[3]);
                                gabinete = _prefs.get(claves[4]);
                                graficas = _prefs.get(claves[5]);
                                coolerGabinete = _prefs.get(claves[6]);
                                ram = _prefs.get(claves[7]);
                                almacenamiento = _prefs.get(claves[8]);
                                fuentePoder = _prefs.get(claves[9]);
                                String uid = _auth.currentUser.uid;
                                String mid = new DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString();

                                await _db.doc().set({
                                  'uid': uid,
                                  'modeloId': mid,
                                  'almacenamiento': almacenamiento,
                                  'coolerGabinete': coolerGabinete,
                                  'cpuCooler': cpuCooler,
                                  'fuentePoder': fuentePoder,
                                  'gabinete': gabinete,
                                  'graficas': graficas,
                                  'motherboard': motherboard,
                                  'procesador': procesador,
                                  'ram': ram
                                }).then((value) => Fluttertoast.showToast(
                                        msg: "Modelo agregado correctamente",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.blue[200],
                                        textColor: Colors.white,
                                        fontSize: 16.0)
                                    .catchError((error) =>
                                        Fluttertoast.showToast(
                                            msg: "Ocurrió algún error",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 4,
                                            backgroundColor: Colors.blue[200],
                                            textColor: Colors.white,
                                            fontSize: 16.0)));
                                //Agregar función de añadir a BD
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
            FAProgressBar(
              currentValue: _currentValue,
              maxValue: 100,
              size: 25,
              changeProgressColor: Colors.teal,
              progressColor: Colors.greenAccent,
              displayText: '%',
              animatedDuration: const Duration(milliseconds: 1000),
            ),
            SizedBox(
              height: 15,
            ),
            GFTypography(
              text: 'Componentes',
              textColor: Colors.white,
              dividerColor: Color(0xff00e9ca),
            ),
            Card(
              child: GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.select_all),
                  title: Text('Procesador'),
                  trailing: check[0]
                      ? Icon(Icons.check)
                      : Icon(Icons.keyboard_arrow_right),
                  onTap: () async {
                    establecerValor();
                    Navigator.of(context).push(MaterialPageRoute(
                      //builder: (context) => components(comp: 'Procesador'),
                      builder: (context) => ListProcesador(),
                    ));
                    check[0] = !check[0]; //Cambia el ícono a seleccionado
                  },
                ),
              ),
            ),
            Card(
              child: GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.blur_linear),
                  title: Text('Tarjeta madre'),
                  trailing: check[1]
                      ? Icon(Icons.check)
                      : Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    establecerValor();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListMotherboard(),
                    ));
                    if (!check[1]) {
                      check[1] = !check[1];
                    } else {
                      check[1] = check[1];
                    }
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.ac_unit),
                title: Text('Enfriamiento CPU'),
                trailing: check[2]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListCoolerCPU(),
                  ));
                  check[2] = !check[2];
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(MyFlutterApp.icons8_workstation_24),
                title: Text('Gabinete'),
                trailing: check[3]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListGabinete(),
                  ));
                  check[3] = !check[3];
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.card_membership),
                title: Text('Tarjeta gráfica'),
                trailing: check[4]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListGraficas(),
                  ));
                  check[4] = !check[4];
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.compare_arrows),
                title: Text('Enfriamiento gabinete'),
                trailing: check[5]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListCoolerGabinete(),
                  ));
                  check[5] = !check[5];
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.memory),
                title: Text('Memoria RAM'),
                trailing: check[6]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListRAM(),
                  ));
                  check[6] = !check[6];
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.storage),
                title: Text('Almacenamiento'),
                trailing: check[7]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListAlmacenamiento(),
                  ));
                  check[7] = !check[7];
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.flash_on),
                title: Text('Fuente de poder'),
                trailing: check[8]
                    ? Icon(Icons.check)
                    : Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  establecerValor();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListFuentePoder(),
                  ));
                  check[8] = !check[8];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
