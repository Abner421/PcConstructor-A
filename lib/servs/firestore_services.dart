import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pc_constructor_a/model/modelo.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _modelosCollection =
      FirebaseFirestore.instance.collection('modelos');

  Future addModelo(Modelo modelo) async {
    try {
      await _modelosCollection.add(modelo.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // Stream> getProducts(){
  //   return _db.collection('products').snapshots().map((snapshot) => snapshot.documents.map((document) => Product.fromFirestore(document.data)).toList());
  // }

  Future removeProduct(String productId) {
    return _db.collection('products').document(productId).delete();
  }
}
