import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_constructor_a/screens/modelos_creados.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfViewScreen extends StatelessWidget {
  final String path;
  final pdf = pw.Document();

  PdfViewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text("Modelo de PC"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              Directory docDir = await getApplicationDocumentsDirectory();
              String docPath = docDir.path;
              File file = File("$docPath/modelo.pdf");
              file.writeAsBytes(pdf.save());
              Fluttertoast.showToast(
                  msg: "PDF guardado correctamente",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pop(context);
            },
          )
        ],
      ),
      path: path,
    );
  }
}
