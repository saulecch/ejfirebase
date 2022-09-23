import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetHelado extends StatelessWidget {
  final String documentId;

  GetHelado(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference helados =
        FirebaseFirestore.instance.collection('icecream');

    return FutureBuilder<DocumentSnapshot>(
      future: helados.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Algo salio mal.");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("El documento no existe.");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              "Helado: ${data['nombre']}, ${data['precio']}, ${data['tamano']}");
        }

        return Text("cargando...");
      },
    );
  }
}

Stream heladosCollectionStream =
    FirebaseFirestore.instance.collection('helados').snapshots();

class GetHelados extends StatefulWidget {
  @override
  _GetHeladosState createState() => _GetHeladosState();
}

class _GetHeladosState extends State<GetHelados> {
  final Stream<QuerySnapshot> _heladosStream =
      FirebaseFirestore.instance.collection('helados').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _heladosStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo salio mal');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Cargando...");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                ListTile(
                  title: Text(data['nombre']),
                  subtitle: Text(data['tamano']),
                  trailing: Text(data['precio']),
                ),
                const Divider()
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
