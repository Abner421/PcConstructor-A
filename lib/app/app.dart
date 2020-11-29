import 'package:pc_constructor_a/screens/splashScreen.dart';
import 'package:flutter/material.dart';

class AppConstructor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Para que se ejcute correctamente los widgets se debe colocar
    // material.dart y estar dentro
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Elimina el banner en modo debug
      theme: ThemeData.light(), // se puede cambiar la propiedad a .light()
      home: SplashScreen(),
    );
  }
}
