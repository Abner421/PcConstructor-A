import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pc_constructor_a/screens/loginScreen.dart';
import 'package:pc_constructor_a/screens/modelScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pc_constructor_a/screens/modelos_creados.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => HomeScreen(mensaje: mensaje),
    );
  }

  final String mensaje;

  HomeScreen({Key key, @required this.mensaje}) : super(key: key);

  //ParseUser parseUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '¡Hola de nuevo!',
                style: TextStyle(
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.green,
                textColor: Colors.white,
                label: Text("Nuevo modelo"),
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => modelScreen()),
                    //MaterialPageRoute(builder: (context) => ListViewProcesador()),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.orange,
                textColor: Colors.white,
                label: Text("Modelos creados"),
                icon: Icon(Icons.save_alt),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModelosCreados()),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.red,
                textColor: Colors.white,
                label: Text("Cerrar sesión"),
                icon: Icon(Icons.close),
                onPressed: () async {
                  _auth.signOut();
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Cierre de sesión'),
                        content: Text(
                            'Sesión cerrada correctamente, datos guardados'),
                        actions: [
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginScreen()));
                            },
                          )
                        ],
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
