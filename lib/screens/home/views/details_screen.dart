import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:giventake/screens/home/views/profile_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

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
                                builder: (BuildContext context) =>
                                  ProfileScreen(
                                  user: MyUserEntity(
                                    userId: product.user!.userId,
                                    email: product.user!.email,
                                    name: product.user!.name,
                                    reviews: product.user!.reviews,
                                    bio: product.user!.bio,
                                  ),
                                  productRepo: FirebaseProductRepo(),
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
              onPressed: () {
                saveRequestToFirestore(productId: product.id, requesterId: product.userId);
                print("REQUEST SAVED\n");
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
          Text(product.user!.name),
          Text(product.location),
          Text(product.description),
          Text(product.location),
        ],
      ),
    );
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> saveRequestToFirestore(
      {required String productId,
       required String requesterId}) async {
    String res = "Some error occurred";
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      String fromUserId = userId;

      bool accepted = false;

      String id = const Uuid().v4();

      if (productId.isNotEmpty ||
          requesterId.isNotEmpty) {
        await _firestore.collection('requests').add({
          'id': id,
          'accepted': accepted,
          'fromUserId': fromUserId,
          'productId': productId,
          'requesterId': requesterId,
        });

        res = 'sucess';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<bool> canRequest(String userId) async {
    final currUserRequests = _firestore.collection('requests').where("fromUserId", isEqualTo: userId).where("productId", isEqualTo: product.id);
    AggregateQuerySnapshot query = await currUserRequests.count().get();

    if (query.count! > 0) {
      return false;
    }
    return true;
  }
}