import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pc_constructor_a/screens/pdf_view.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final FirebaseFirestore _db = FirebaseFirestore.instance;
final User _user = FirebaseAuth.instance.currentUser;
String modelo;
var almacenamiento;
var cpuCooler;
var coolerGabinete;
var fuentePoder;
var gabinete;
var graficas;
var motherboard;
var procesador;
var ram;
var identModelo;
var idModel;
Map<String, dynamic> modelDetails = {};
List<String> myList = List<String>();

class ModelosCreados extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModelosCreados();
}

class _ModelosCreados extends State<ModelosCreados> {
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: _db
                .collection('modelos')
                .where('uid', isEqualTo: _user.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView(children: getModelos(snapshot));
            }),
      ),
    );
  }

  getModelos(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs
        .map((e) => new GFAccordion(
              contentBackgroundColor: Colors.grey[300],
              titleChild: Text(
                'ID de modelo: ' + e['modeloId'].toString(),
                style: TextStyle(color: Colors.white),
              ),
              contentChild: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Almacenamiento: ' + e['almacenamiento'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Fuente de poder: ' + e['fuentePoder'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Tarjeta gráfica: ' + e['graficas'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Tarjeta madre: ' + e['motherboard'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Procesador: ' + e['procesador'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Gabinete: ' + e['gabinete'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Enfriamiento gabinete: ' + e['coolerGabinete'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Enfriamiento CPU: ' + e['cpuCooler'],
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Memoria RAM: ' + e['ram'],
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Material(
                    color: Colors.grey[300],
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Color(0xffB593CC),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.picture_as_pdf),
                          color: Colors.white,
                          onPressed: () async {
                            identModelo = e['modeloId'];
                            print("ID MODELO: " + identModelo);
                            getModelosBD(identModelo);
                            writeOnPdf();

                            await guardarPDF();

                            Directory docDir =
                                await getApplicationDocumentsDirectory();

                            String docPath = docDir.path;
                            String fullPath = "$docPath/modelo.pdf";
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewScreen(
                                          path: fullPath,
                                        )));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              collapsedIcon: Text(
                'Mostrar',
                style: TextStyle(color: Colors.white),
              ),
              expandedIcon: Text(
                'Ocultar',
                style: TextStyle(color: Colors.white),
              ),
              collapsedTitleBackgroundColor: Color(0xff7B32D9),
              expandedTitleBackgroundColor: Color(0xffB593CC),
              titleBorderRadius: BorderRadius.circular(3),
            ))
        .toList();
  }

  escribirPDF(almacenamiento, cpuCooler, coolerGabinete, fuentePoder, gabinete,
      graficas, motherboard, procesador, ram, identModelo) async {
    print("Prueba de cadena: alamacneamiento" + almacenamiento);
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(level: 0, child: pw.Text('Lista de componentes')),
            pw.Paragraph(text: 'El elemento de almacenamiento es: '),
            pw.Paragraph(text: 'A ver como se ve'),
          ];
        }));
  }

  writeOnPdf() {
    var marcaProcesador;
    var marcaAlmacenamiento;
    var marcaCoolerCPU;
    var marcaCoolerGabinete;
    var marcaFuentePoder;
    var marcaGabinete;
    var marcaGraficas;
    var marcaMotherboard;
    var marcaRam;

    if (myList[2] == '970 EVO') {
      marcaAlmacenamiento = 'Samsung';
    } else if (myList[2] == 'Caviar Blue') {
      marcaAlmacenamiento = 'Western Digital';
    } else if (myList[2] == 'A400') {
      marcaAlmacenamiento = 'Kingston';
    } else if (myList[2] == 'BarraCuda') {
      marcaAlmacenamiento = 'Seagate';
    }

    if (myList[1] == 'Hyper 212 EVO') {
      marcaCoolerCPU = 'Cooler Master';
    } else if (myList[1] == 'H100i RGB') {
      marcaCoolerCPU = 'Corsair';
    } else if (myList[1] == 'Kraken X63') {
      marcaCoolerCPU = 'NZXT';
    } else if (myList[1] == 'Dark Rock Pro 4') {
      marcaCoolerCPU = 'Be quiet!';
    }

    if (myList[0] == 'Cooler Master') {
      marcaCoolerGabinete = 'MasterFan MF120R';
    } else if (myList[0] == 'LL120') {
      marcaCoolerGabinete = 'Corsair';
    } else if (myList[0] == 'P12') {
      marcaCoolerGabinete = 'ARCTIC';
    }

    if (myList[3] == 'RM750') {
      marcaFuentePoder = 'Corsair 80+Gold';
    } else if (myList[3] == 'CX 650') {
      marcaFuentePoder = 'Corsair 80+Bronze';
    } else if (myList[3] == 'V1000') {
      marcaFuentePoder = 'Cooler Master 80+';
    } else if (myList[3] == 'BQ500') {
      marcaFuentePoder = 'EVGA';
    }

    if (myList[4] == 'Lancool2-X') {
      marcaGabinete = 'Lian Li';
    } else if (myList[4] == 'H510B-W1') {
      marcaGabinete = 'NZXT';
    } else if (myList[4] == 'Q300L') {
      marcaGabinete = 'Cooler Master';
    }

    if (myList[5] == 'Windforce OC') {
      marcaGraficas = 'Gigabyte';
    } else if (myList[5] == 'Founders Edition') {
      marcaGraficas = 'NVIDIA';
    } else if (myList[5] == 'ROG Strix GeForce RTX 2080Ti') {
      marcaGraficas = 'ASUS';
    }

    if (myList[6] == 'N7 Z390' || myList[6] == 'LGA 1151') {
      marcaMotherboard = 'NZXT';
    } else if (myList[6] == 'TRX40 Arous Pro Wifi' || myList[6] == 'TRX4') {
      marcaMotherboard = 'Gigabyte';
    } else if (myList[6] == 'B450 Aorus Elite' || myList[6] == 'AM4') {
      marcaMotherboard = 'AMD';
    } else if (myList[6] == 'B450M PRO4-F' || myList[6] == 'AM4') {
      marcaMotherboard = 'ASRock';
    } else if (myList[6] == 'ROG Rampage VI Extreme' ||
        myList[6] == 'LGA 2066') {
      marcaMotherboard = 'ASUS';
    }

    if (myList[7] == 'Ryzen Threadripper 3990X' || myList[7] == 'TRX4') {
      marcaProcesador = 'AMD';
    } else if (myList[7] == 'Ryzen 9 3950X' || myList[7] == 'AM4') {
      marcaProcesador = 'AMD';
    } else if (myList[7] == 'Core i5-6500' || myList[7] == 'LGA 1151') {
      marcaProcesador = 'Intel';
    } else if (myList[7] == 'Core i9-10980XE' || myList[7] == 'LGA 2066') {
      marcaProcesador = 'Intel';
    }

    if (myList[8] == 'T-Force Vulcan Z') {
      marcaRam = 'TEAM GROUP 2x8 DDR4';
    } else if (myList[8] == 'RipJaws V') {
      marcaRam = 'G.Skill 2x16 DDR4';
    } else if (myList[8] == 'XPG SPECTRIX') {
      marcaRam = 'ADATA 2x8 DDR4';
    } else if (myList[8] == 'Vengeance LPX') {
      marcaRam = 'Corsair 2x8 DDR4';
    }
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.letter,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 1,
              child: pw.Text("Identificador del modelo: #" + myList[9])),
          pw.Paragraph(
              text: "Almacenamiento: " + marcaAlmacenamiento + ' ' + myList[2]),
          pw.Paragraph(
              text: "Enfriador CPU: " + marcaCoolerCPU + ' ' + myList[1]),
          pw.Paragraph(
              text: "Enfriamiento gabinete: " +
                  marcaCoolerGabinete +
                  ' ' +
                  myList[0]),
          pw.Paragraph(
              text: "Fuente de Poder: " + marcaFuentePoder + ' ' + myList[3]),
          pw.Paragraph(text: "Gabinete: " + marcaGabinete + ' ' + myList[4]),
          pw.Paragraph(
              text: "Tarjeta gráfica: " + marcaGraficas + ' ' + myList[5]),
          pw.Paragraph(text: "Tarjeta madre: Gigabyte" + myList[6]),
          pw.Paragraph(
              text: "Procesador: " + marcaProcesador + ' ' + myList[7]),
          pw.Paragraph(text: "Memoria RAM: " + marcaRam + ' ' + myList[8]),
        ];
      },
    ));
  }

  Future guardarPDF() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String docPath = docDir.path;
    File file = File("$docPath/modelo.pdf");
    file.writeAsBytes(pdf.save());
  }

  getModelosBD(String mID) {
    FirebaseFirestore.instance
        .collection('modelos')
        .doc(mID)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        almacenamiento = snapshot.data()['almacenamiento'];
        cpuCooler = snapshot.data()['cpuCooler'];
        coolerGabinete = snapshot.data()['coolerGabinete'];
        fuentePoder = snapshot.data()['fuentePoder'];
        gabinete = snapshot.data()['gabinete'];
        graficas = snapshot.data()['graficas'];
        motherboard = snapshot.data()['motherboard'];
        procesador = snapshot.data()['procesador'];
        ram = snapshot.data()['ram'];
        idModel = snapshot.data()['modeloId'];

        print("Escribirendo en PDF...");
        print("TErminando de escrbir");
        myList.add(almacenamiento);
        myList.add(cpuCooler);
        myList.add(coolerGabinete);
        myList.add(fuentePoder);
        myList.add(gabinete);
        myList.add(graficas);
        myList.add(motherboard);
        myList.add(procesador);
        myList.add(ram);
        myList.add(idModel);
      }
    });
  }
}
