import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_user_products/get_user_products_bloc.dart';
import 'package:giventake/screens/profile/views/profile_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  DetailsScreen({
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.image),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    Text(
                      product.location,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        const SizedBox(width: 8.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (context) => GetUserProductsBloc(
                                      FirebaseProductRepo()),
                                  child: ProfileScreen(
                                    user: MyUserEntity(
                                      userId: product.user!.userId,
                                      email: product.user!.email,
                                      name: product.user!.name,
                                      reviews: product.user!.reviews,
                                      bio: product.user!.bio,
                                      rating: product.user!.rating,
                                      image: product.user!.image,
                                    ),
                                    productRepo: FirebaseProductRepo(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            product.user!.name,
                            style: const TextStyle(
                              color: Colors.black, // Cor do texto
                              fontSize: 16, // Tamanho do texto
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Theme.of(context).colorScheme.tertiary,
                child: const Text(
                  "Everything in this section is given away for free 💚. Strictly no selling, no swaps, no donations.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                String result = await saveRequestToFirestore(
                    productId: product.id, requesterId: product.userId);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result == 'success'
                        ? 'Request saved successfully!'
                        : 'You have already requested this product!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Request Product"),
            ),
          ),
        ],
      ),
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> saveRequestToFirestore(
      {required String productId, required String requesterId}) async {
    String res = "Some error occurred";
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      String fromUserId = userId;

      if (!await canRequest(fromUserId)) {
        return 'fail';
      }

      bool accepted = false;

      String id = const Uuid().v4();

      if (productId.isNotEmpty || requesterId.isNotEmpty) {
        await _firestore.collection('requests').add({
          'id': id,
          'accepted': accepted,
          'fromUserId': fromUserId,
          'productId': productId,
          'requesterId': requesterId,
        });

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<bool> canRequest(String userId) async {
    final currUserRequests = _firestore
        .collection('requests')
        .where("fromUserId", isEqualTo: userId)
        .where("productId", isEqualTo: product.id);
    AggregateQuerySnapshot query = await currUserRequests.count().get();

    if (query.count! > 0) {
      return false;
    }
    return true;
  }
}
