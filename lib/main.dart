import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:giventake/app.dart';
import 'package:giventake/firebase_options.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  //await FirebaseAppCheck.instance.activate();
  runApp(MyApp(FirebaseUserRepo()));

}
