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
                    Row( // Adicionando uma linha para organizar o nome do usuário e o botão
                      children: [
                        Text(product.user!.name),
                        const SizedBox(width: 8.0), // Adicionando um espaçamento entre o nome do usuário e o botão
                        ElevatedButton( // Botão para mudar de tela
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(builder: (BuildContext context) =>
                                  ProfileScreen(user: MyUserEntity(userId: product.user!.userId, email: product.user!.email, name: product.user!.name, reviews: product.user!.reviews)),), // Substitua OtherScreen pela tela de destino
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Change Screen"),
                        ),
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
                String? userId = FirebaseAuth.instance.currentUser?.uid;
                if (userId != null) {
                  Request request = await Request.createWithRequesterId(userId, product.id);
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
