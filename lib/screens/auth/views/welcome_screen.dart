import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('GiveNTake'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Welcome to the GiveNTake app!',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              )),
              const SizedBox(height: 20),
              const Text('This app was designed by:'),
              const SizedBox(height: 10),
              const Text('1. João Santos'),
              const Text('2. Eduardo Baltazar'),
              const Text('3. Sara Cortez'),
              const Text('4. Joana Noites'),
              const Text('5. Marta Silva'),
            ],
          ),
        ));
  }
}
