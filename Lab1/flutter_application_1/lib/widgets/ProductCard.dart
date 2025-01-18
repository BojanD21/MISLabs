import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/screens/ProductDetailScreen.dart';

class ProductCard extends StatelessWidget {
    final Product product;

    const ProductCard({super.key, required this.product});

    @override
    Widget build(BuildContext context) {
        return InkWell(
            onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Productdetailscreen(product: product),
                    ),
                );
            },
            child: Card(
                child: Column(
                    children: [
                        Image.network(product.image, fit: BoxFit.cover, height: 150),
                        SizedBox(height: 16),
                        Text(
                          product.name, 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 8),
                        Text(product.description),
                        SizedBox(height: 8),
                        Text('\$ ${product.price}', 
                          style: TextStyle(color: Colors.green, fontSize: 16)),
                    ],
                ),
            ),
        );
    }
}