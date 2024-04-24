import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.image),
          const SizedBox(height: 16.0),
          Text(
            product.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          Text(product.user!.name),
          Text(product.location),
          Text(product.description),
          Text(product.location),
        ],
      ),
    );
  }
}