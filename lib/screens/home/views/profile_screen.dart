import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  final MyUserEntity user;
  const ProfileScreen({
    super.key,
    required this.user,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            // Aqui você pode exibir outras informações do usuário
          ],
        ),
      ),
    );
  }
}