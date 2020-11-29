import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getwidget/getwidget.dart';
import 'package:email_validator/email_validator.dart';

import 'package:pc_constructor_a/screens/loginScreen.dart';

class signUpScreen extends StatefulWidget {
  @override
  _signUpScreen createState() => _signUpScreen();
}

class _signUpScreen extends State<signUpScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  String email, pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text('Registro'),
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
                'Formulario de registro',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "Ingresa tu dirección de correo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass = value; //get the value entered by user.
                },
                decoration: InputDecoration(
                    hintText: "Ingresa tu contraseña",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(
                height: 20,
              ),
              Text('La contraseña debe contener:\n'
                  'Entre 8 y 16 caracteres\n'
                  'Al menos 1 dígito, 1 mayúscula y 1 minúscula\n'),
              SizedBox(height: 20.0),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showProgress = true;
                    });
                    try {
                      if (!EmailValidator.validate(email)) {
                        print("Email no válido");
                        setState(() {
                          showProgress = false;
                        });
                        showFlash(
                          context: context,
                          persistent: true,
                          builder: (_, controller) {
                            return Flash(
                              controller: controller,
                              margin: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(10.0),
                              borderColor: Colors.white,
                              boxShadows: kElevationToShadow[8],
                              backgroundGradient: RadialGradient(
                                colors: [Color(0xffD9AFD9), Color(0xff97D9E1)],
                                center: Alignment.topLeft,
                                radius: 2,
                              ),
                              onTap: () => controller.dismiss(),
                              forwardAnimationCurve: Curves.easeInCirc,
                              reverseAnimationCurve: Curves.bounceIn,
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                                child: FlashBar(
                                  title: Text('Error'),
                                  message: Text(
                                      'El formato de email es incorrecto, veríficalo'),
                                  leftBarIndicatorColor: Colors.red,
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                  primaryAction: FlatButton(
                                    onPressed: () => controller.dismiss(),
                                    child: Text('OK'),
                                  ),
                                  /*actions: <Widget>[
                                    FlatButton(
                                        onPressed: () => controller.dismiss('Yes, I do!'),
                                        child: Text('YES')),
                                    FlatButton(
                                        onPressed: () => controller.dismiss('No, I do not!'),
                                        child: Text('NO')),
                                  ],*/
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: pass);
                        if (newuser != null) {
                          _auth.currentUser.sendEmailVerification();
                          Fluttertoast.showToast(
                              msg:
                                  "Un correo de verificación ha sido enviado. Revisa tu correo 📧",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.blue[200],
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                          setState(() {
                            showProgress = false;
                          });
                        }
                      }
                    } catch (e) {}
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  '¿Ya tienes cuenta? Inicia sesión',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
