import 'package:flutter/material.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/pages/order.dart';
import 'package:shoppingapp/services/local_db.dart';
import 'package:shoppingapp/widget/support_widget.dart';

class ProductDetail extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productDetail;

  const ProductDetail({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDetail,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  void bookNow(BuildContext context) {
    // Save booking
    LocalDB.addOrder({
      "name": widget.productName,
      "price": widget.productPrice,
      "image": widget.productImage,
      "date": DateTime.now().toString(),
    });

    // Show booking success
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Order placed Successful ✅"),
        content: Text("${widget.productName} has been ordered successfully."),
        actions: [
          TextButton(
            child: const Text("View Orders"),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderPage()),
              );
            },
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfef5f1),
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Back Arrow Button
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),

                // Product Image
                Center(child: Image.asset(widget.productImage, height: 400)),
              ],
            ),

            // Product Details
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.productName,
                          style: AppWidget.boldtextfieldStyle(),
                        ),
                        Text(
                          "\$${widget.productPrice}",
                          style: const TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Details Title
                    Text("Details", style: AppWidget.semiboldtextfieldStyle()),
                    SizedBox(height: 10),

                    // Description
                    Text(widget.productDetail),

                    const Spacer(),

                    // Buy Now Button
                    GestureDetector(
                      onTap: () => bookNow(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFfd6f3e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
