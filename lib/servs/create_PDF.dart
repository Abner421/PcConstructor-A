import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

final doc = pw.Document();

Future<File> createPDF() async {
  doc.addPage(pw.Page(
      build: (pw.Context context) => pw.Center(child: pw.Text('Qué tranza'))));

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/example.pdf');
  file.writeAsBytes(doc.save());

  print('La ruta del archivo eS: ' + output.path);

  return file;
}
