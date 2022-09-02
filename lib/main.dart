import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: AddHelado(),
      ),
    );
  }
}

// Widget
class AddHelado extends StatelessWidget {
  const AddHelado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Declaración referencia
    CollectionReference helados =
        FirebaseFirestore.instance.collection('helados');

// Función
    Future<void> addHelado(String nombre, String precio, String tamano) {
      return helados
          .add({'nombre': nombre, 'precio': precio, 'tamano': tamano})
          .then(
            (value) => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Helado añadido'),
                content: Text('El helado de $nombre ha sido añadido'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          )
          .catchError(
            (error) => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text('$error'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          );
    }

    return TextButton(
      onPressed: () => addHelado('Napolitano', 'Q.10.00', 'Grande'),
      child: const Text(
        "Añadir Helado",
      ),
    );
  }
}
