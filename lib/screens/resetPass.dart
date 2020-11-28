import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getwidget/getwidget.dart';

import 'package:pc_constructor_a/screens/loginScreen.dart';

class resetPass extends StatefulWidget {
  @override
  _resetPass createState() => _resetPass();
}

Future<void> resetPwd(String email) async{
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.sendPasswordResetEmail(email: email);
}

Future<bool> _getTimer(){
  return Future.delayed(Duration(seconds: 2))
      .then((value) => true);
}

class _resetPass extends State<resetPass> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String msg){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  String email, pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: GFAppBar(
        title: Text('Reestablecer contraseña'),
        leading: Container(),
        centerTitle: true,
      ),
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Reestablecimiento de contraseña',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Ingresa tu dirección de correo para que puedas recuperar tu contraseña',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "ejemplo@ejemplo.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () {
                      try{
                        resetPwd(email);
                        Future.delayed(Duration(seconds: 2), (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        });
                        _showScaffold("Correo enviado correctamente a " + email);
                      }catch(e){}
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    'Recuperar contraseña',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
