import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellItem extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;

    CollectionReference items = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection("itens");


    Future<void> updateSaleInfo(String id) {
      return items
        .doc(id)
        .update({'isForSale' : true})
        .then((value) => print("Info Updated"))
        .catchError(
            (error) => print("Failed to update info: $error"));
        }

    Future<void> _showMyDialog(String id) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sell Item'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Would you like sell this item?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                child: Text('Approve'),
                onPressed: () {
                  updateSaleInfo(id);
                },
              ),
            ],
          );
        },
      );
    }

    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: items.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return new ListTile(
                onTap: () {
                  return _showMyDialog(document.id);
                },
                title: new Text(document.data()['name']),
                subtitle: new Text(document.data()['lvl']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
