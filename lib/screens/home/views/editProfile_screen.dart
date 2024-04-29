import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}


class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController =
      TextEditingController();
  final TextEditingController userBioController =
      TextEditingController();
  final TextEditingController userImageController = TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  

  @override
  void dispose() {
    userNameController.dispose();
    userEmailController.dispose();
    userBioController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Uint8List? photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseUserRepo().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Se estiver esperando dados, você pode exibir um indicador de carregamento
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              // Se ocorrer um erro, você pode exibir uma mensagem de erro
              return Center(
                child: Text('Erro ao carregar dados do usuário'),
              );
            } else {
              // Se não houver erro, verifique se o usuário está logado
              final user = snapshot.data;
              if (user != null) {
                
                return Column(
            children: [
              Text('Usuário logado: ${user.email}'),
              Text(
                'Add a new product',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 30.0),
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: photo != null
                      ? Image.memory(
                          photo!,
                          fit: BoxFit.cover,
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.black,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Upload an Image',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Use any proper format: PNG, JPG, WEBP, JPEG up to 4MB',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                  labelText: 'Edit name',
                  hintText: 'Name',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: userEmailController,
                decoration: const InputDecoration(
                  labelText: 'Edit email',
                  hintText: 'Email',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Edit password',
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: 16.0),
              TextFormField(
                controller: userBioController,
                decoration: const InputDecoration(
                  labelText: 'Edit bio',
                  hintText: 'Bio',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  updateUserInfo().then((result) {
                    if (result == 'success') {
                    // Atualize os controladores dos campos de texto com as novas informações do usuário
                    setState(() {
                      String updatedName = userNameController.text;
                      String updatedEmail = userEmailController.text;
                      String updatedBio = userBioController.text;
                      
                      // Atualize os controladores com as novas informações
                      userNameController.text = updatedName;
                      userEmailController.text = updatedEmail;
                      userBioController.text = updatedBio;
                    });
                    // Feche a tela de edição do perfil
                    Navigator.of(context).pop(true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erro ao atualizar o perfil")),
                    );
                  }
                  });

                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Upload Product',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
              } else {
                
                return Center(
                  child: Text('Nenhum usuário logado'),
                );
              }
            }
          }
        },
      ),
    );
  }

 pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    Text('No image selected');
  }
  void selectImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    print('File selected: $file');
    setState(() {
      photo = file;
    });
  }

  void reauthenticateUser(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);
      print('Usuário reautenticado com sucesso.');
      // Agora você pode realizar operações sensíveis, como atualizar o e-mail ou a senha
    } catch (error) {
      print('Erro ao reautenticar o usuário: $error');
    }
  }

// Função para atualizar o e-mail do usuário
void updateEmail(String newEmail) async {
  try {
    // Obtenha a instância do FirebaseAuth
    FirebaseAuth _auth = FirebaseAuth.instance;

    // Verifique se há um usuário autenticado
    User? user = _auth.currentUser;
    if (user != null) {
      // Atualize o e-mail do usuário
      await user.updateEmail(newEmail);
      print('E-mail atualizado com sucesso para: $newEmail');
    } else {
      // Se não houver usuário autenticado, exiba uma mensagem de erro
      print('Nenhum usuário autenticado.');
    }
  } catch (e) {
    // Se ocorrer algum erro, exiba a mensagem de erro
    print('Erro ao atualizar o e-mail: $e');
  }
}


// Função para atualizar a senha do usuário
void updatePassword(String newPassword) async {
  try {
    // Obtenha a instância do FirebaseAuth
    FirebaseAuth _auth = FirebaseAuth.instance;

    // Verifique se há um usuário autenticado
    User? user = _auth.currentUser;
    if (user != null) {
      // Atualize a senha do usuário
      await user.updatePassword(newPassword);
      print('Senha atualizada com sucesso.');
    } else {
      // Se não houver usuário autenticado, exiba uma mensagem de erro
      print('Nenhum usuário autenticado.');
    }
  } catch (e) {
    // Se ocorrer algum erro, exiba a mensagem de erro
    print('Erro ao atualizar a senha: $e');
  }
}


  Future<String> updateUserInfo() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String name = userNameController.text;
    String email = userEmailController.text;
    String bio = userBioController.text;
    String password = passwordController.text;
  

    if (userId.isNotEmpty && (name.isNotEmpty || email.isNotEmpty || bio.isNotEmpty || photo != null)) {
      String imageUrl = '';
      if (photo != null) {
        // Se uma nova foto for selecionada, faça o upload dela para o Firebase Storage
        imageUrl = await uploadImageToStorage('userImage_$userId', photo!);
      }

      // Atualize os dados do usuário no Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': name,
        'email': email,
        'bio': bio,
        'image': imageUrl, 
      });

    updateEmail(email);
    updatePassword(password);

    reauthenticateUser(email, password);

      await FirebaseAuth.instance.currentUser?.reload();
      await Future.delayed(Duration(seconds: 2)); 
      return 'success';
    } else {
      return 'Please provide at least one field to update.';
    }
  } catch (error) {
    return 'An error occurred: $error';
  }
}


  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String imagePath, Uint8List file) async {
    Reference ref = _storage.ref().child(imagePath);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  /*Future<String> saveProductToFirestore(
      {required String name,
      required String email,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String id = const Uuid().v4();

      if (name.isNotEmpty ||
          email.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('productImage', file);
        await _firestore.collection('products').add({
          'id': id,
          'userId': userId,
          'name': name,
          'email': email,
          'bio': bio,
          'image': imageUrl,
        });

        res = 'sucess';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }*/
}
