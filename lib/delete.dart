import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference helados = FirebaseFirestore.instance.collection('helados');

Future<void> deleteHelados(String id) {
  return helados
      .doc(id)
      .delete()
      .then((value) => print("Helados Deleted"))
      .catchError((error) => print("Failed to delete helados: $error"));
}
