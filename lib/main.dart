import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pc_constructor_a/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppConstructor());
}
