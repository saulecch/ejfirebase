import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('helados');

Future<void> updateHelado(
    String id, String nombre, String precio, String tamano) {
  return users
      .doc(id)
      .update({'nombre': nombre, 'precio': precio, 'tamano': tamano})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}
