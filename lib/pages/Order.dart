import 'package:flutter/material.dart';
import 'package:shoppingapp/services/local_db.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = LocalDB.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("My Orders")),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: orders.isEmpty
          ? Center(child: Text("No orders yet."))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.asset(order["image"], width: 50, height: 50),
                    title: Text(order["name"]),
                    subtitle: Text(
                      "Ordered on: ${order["date"].toString().substring(0, 16)}",
                    ),
                    trailing: Text(
                      "\$${order["price"]}",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
