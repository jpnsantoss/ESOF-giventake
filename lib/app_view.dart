import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:giventake/screens/auth/views/welcome_screen.dart';
import 'package:giventake/screens/home/blocs/get_product_bloc/get_product_bloc.dart';
import 'package:giventake/screens/home/views/home_screen.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiveNTake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.light(
          background: Color(0xFFF7F7F7),
          onBackground: Color(0xFF818181),
          primary: Color(0xFF6C8A47),
          onPrimary: Colors.white,
          secondary: Color(0xFF97BE78),
          onSecondary: Colors.white,
          tertiary: Color(0xFFECEAEB),
          onTertiary: Color(0xFF818181),
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => GetProductBloc(
                FirebaseProductRepo(),
                FirebaseUserRepo(),
              )..add(GetProduct()),
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        }),
      ),
    );
  }
}
