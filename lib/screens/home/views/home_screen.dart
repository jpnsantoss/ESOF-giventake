import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:giventake/screens/product/views/upload_product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
          
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const SizedBox(height: 20.0),
            // Botão "Upload Product"
            TextButton(
              onPressed: () {
                // Navegue para a tela de adicionar produto
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductUploadScreen(),
                ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  "Upload Product",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
