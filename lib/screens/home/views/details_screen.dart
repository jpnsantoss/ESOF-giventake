import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giventake/screens/home/views/profile_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:request_repository/request_repository.dart';

class DetailsScreen extends StatelessWidget {

  final Product product;
  final RequestRepo requestRepo = FirebaseRequestRepo();

  DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing UI code here
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () async {
                String? userId = FirebaseAuth.instance.currentUser?.uid;
                if (userId != null) {
                  Request request = Request(fromUserId: userId, productId: product.id, id: );
                  await requestRepo.addRequest(request);
                } else {
                  print(
                      'Error: Couldn\'t get User ID. Ensure you are logged in.');
                }
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
}
