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
        children: [
          Image.network(product.image),
          Text(product.title),
          Text(product.description),
          Text(product.location),
        ],
      ),
    );
  }
}
