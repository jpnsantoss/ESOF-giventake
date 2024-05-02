import 'package:flutter/material.dart';
import 'package:giventake/screens/profile/views/profile_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    builder: (BuildContext context) => ProfileScreen(
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
              onPressed: () {},
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
