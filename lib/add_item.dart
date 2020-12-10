import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  final String Name;
  final int ilvl;

  const AddItem({Key key, this.Name, this.ilvl}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final nameController = TextEditingController();
  final ilvlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var uid = user.uid;

    // Create a CollectionReference called items that references the firestore collection
    var itens = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection("itens");

    Future<void> addItem() async {
      //final uid = await Provider.of(context).AuthService.getCurrentUID();
      String name = nameController.text;
      String lvl = ilvlController.text;
      bool isForSale = false;

      // Call the user's CollectionReference to add a new user
      itens
          .add({'name': name, 'lvl': lvl, 'isForSale': isForSale})
          .then((value) => print("Added Item"))
          .catchError((error) => print("Failed to add item: $error"));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add a new Item"),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextFormField(
              controller: ilvlController,
              decoration: InputDecoration(
                labelText: "ilvl",
              ),
            ),
            RaisedButton(
              onPressed: () {
                addItem();
              },
              child: Text("Add Item to Collection"),
            ),
          ],
        ),
      ),
    );
  }
}
