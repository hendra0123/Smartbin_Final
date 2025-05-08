import 'package:flutter/material.dart';
import 'package:smartbin/pages/formredeem_page.dart';

class RedeemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Redeem")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FormRedeemPage()),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.asset('assets/images/voucher.jpg', width: 50),
                title: Text(
                  "Poin UCM",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
