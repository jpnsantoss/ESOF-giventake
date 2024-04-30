import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/home/views/details_screen.dart';
import 'package:giventake/screens/profile/blocs/get_user_products/get_user_products_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserProductsBloc, GetUserProductsState>(
      builder: (context, state) {
        if (state is GetUserProductsSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.description),
                  ],
                ),
                leading: Image.network(product.image),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          DetailsScreen(product: product),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is GetUserProductsProcess) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Failed to load products'),
          );
        }
      },
      // Remove the unnecessary closing parenthesis
    );
  }
}
