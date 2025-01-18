import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/widgets/ProductCard.dart';

class HomeScreen extends StatelessWidget {
	final List<Product> products = [
		Product(
      name: 'T-Shirt',
      image: 'assets/images/tshirt.png',
      description: 'Comfortable cotton T-shirt.',
      price: '10',
		),
		Product(
		name: 'Jeans',
		image: 'assets/images/jeans.jpg',
		description: 'Classic straight-fit jeans.',
		price: '30',
		),
		Product(
		name: 'Jacket',
		image: 'assets/images/jacket.jpg',
		description: 'Warm winter jacket.',
		price: '50',
		),
		Product(
		name: 'Sneakers',
		image: 'assets/images/sneakers.jpg',
		description: 'Everyday sporty sneakers.',
		price: '40',
		),
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('203213'),
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: GridView.builder(
					gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
						crossAxisCount: 3,
						crossAxisSpacing: 10,
						mainAxisSpacing: 10,
					), 
					itemCount: products.length,
					itemBuilder: (context, index) {
						return ProductCard(product: products[index]);
					}) 
			),
		);
	}
}