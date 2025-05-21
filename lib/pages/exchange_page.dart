import 'package:flutter/material.dart';
import 'package:smartbin/pages/formExchange_page.dart';

class ExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Redeem',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FormExchangePage()),
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
