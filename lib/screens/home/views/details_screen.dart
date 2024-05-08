import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/profile/blocs/get_user_products/get_user_products_bloc.dart';
import 'package:giventake/screens/profile/views/profile_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:request_repository/request_repository.dart';
import 'package:review_repository/request_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  DetailsScreen({
    super.key,
    required this.product,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}
  class _DetailsScreenState extends State<DetailsScreen> {
  late List<Review> reviews = [];

  @override
  void initState() {
  super.initState();
  fetchUserReviews(widget.product.user!.userId);
  }

  Future<void> fetchUserReviews(String userId) async {
    try {
      ReviewRepo reviewRepo = FirebaseReviewRepo();
      reviews = await reviewRepo.getReviews(userId);
      setState(() {}); // Update the UI after fetching reviews and rating
    } catch (e) {
      print("Error fetching user reviews: $e");
    }
  }

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
              Image.network(widget.product.image),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    Text(
                      widget.product.location,
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
                                      userId: widget.product.user!.userId,
                                      email: widget.product.user!.email,
                                      name: widget.product.user!.name,
                                      reviews: widget.product.user!.reviews,
                                      bio: widget.product.user!.bio,
                                      rating: widget.product.user!.rating,
                                      image: widget.product.user!.image,
                                    ),
                                    productRepo: FirebaseProductRepo(),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                widget.product.user!.name,
                                style: const TextStyle(
                                  color: Colors.black, // Cor do texto
                                  fontSize: 16, // Tamanho do texto
                                ),
                              ),
                              SizedBox(width: 5), // Spacing between name and rating
                              // Display star rating
                              _buildRatingStars(widget.product.user!.rating),
                              SizedBox(width: 5), // Spacing between rating and reviews count
                              // Display number of reviews
                              Text(
                                '(${reviews.length} reviews)',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      widget.product.description,
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
                    productId: widget.product.id, requesterId: widget.product.userId);
                print("REQUEST SAVED\n");
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

  Widget _buildRatingStars(num rating) {
    return Row(
      children: List.generate(
        rating.ceil(),
            (index) => Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ),
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
        print("user has already requested this product");
        return 'fail';
      }

      bool accepted = false;

      String id = const Uuid().v4();

      if (productId.isNotEmpty || requesterId.isNotEmpty) {
        FirebaseRequestRepo requestRepo = FirebaseRequestRepo();
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
        .where("productId", isEqualTo: widget.product.id);
    AggregateQuerySnapshot query = await currUserRequests.count().get();

    if (query.count! > 0) {
      return false;
    }
    return true;
  }

}
