import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<List<DocumentSnapshot>> getData() async {
  final dados = List<DocumentSnapshot>();

  final data = await FirebaseFirestore.instance.collection('userData').get();

  for (var doc in data.docs) {
    final userData = await FirebaseFirestore.instance
        .collection('userData')
        .doc(doc.id)
        .collection('itens')
        .where('isForSale', isEqualTo: true)
        .get();

    dados.addAll(userData.docs);
  }

  return Future.value(dados);
}

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: getData(),
            builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Deu erro: ${snapshot.error}'));
              }

              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return new ListTile(
                        title: new Text(snapshot.data[index]['name']),
                      );
                    });
              }

              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
