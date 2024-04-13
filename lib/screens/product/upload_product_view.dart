import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giventake/blocs/upload_product_bloc/upload_product_bloc_bloc.dart';


class YourProductPage extends StatelessWidget {
  final ProductBloc productBloc;

  const YourProductPage(this.productBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: productBloc,
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return CircularProgressIndicator();
        } else if (state.status == ProductStatus.loaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
              );
            },
          );
        } else {
          return Text(state.errorMessage ?? 'Error');
        }
      },
    );
  }
}
