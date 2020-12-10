import 'package:flutter/material.dart';
import 'package:auction_house/add_item.dart';
import 'package:auction_house/auth_service.dart';
import 'package:auction_house/market_page.dart';
import 'package:auction_house/sell_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddItem();
                    },
                  ),
                );
              },
              child: Text("Add Item"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SellItem();
                    },
                  ),
                );
              },
              child: Text("Sell Item"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MarketPage();
                    },
                  ),
                );
              },
              child: Text("Market"),
            ),
            RaisedButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
