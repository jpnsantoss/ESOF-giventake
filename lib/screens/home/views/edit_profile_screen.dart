import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_repository/product_repository.dart';
import 'package:request_repository/request_repository.dart';
import 'package:user_repository/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;

  const EditProfileScreen({super.key, required this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String userId;
  /* EXTRACT TO REQUEST LOGIC */
  late List<Request> requests = [];
  late List<MyUser> requestUsers = [];
  bool isLoadingRequests = true;
  /* --------ENDS HERE------------ */
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    /* EXTRACT TO REQUEST LOGIC */
    fetchUnansweredRequests();
    /* --------ENDS HERE------------ */
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userBioController = TextEditingController();
  final TextEditingController userImageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        title: const Text('Your Profile'),
      ),
      body: FutureBuilder<MyUser>(
        future: FirebaseUserRepo().getUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar usuário'));
          } else {
            final user = snapshot.data!;

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(user.image, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: selectImage,
                      child: const Text(
                        'Change Photo',
                        style: TextStyle(
                          color: Colors.blue, // Define a cor do texto como azul
                          decoration: TextDecoration
                              .underline, // Adiciona uma linha por baixo do texto
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(20.0),
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome: ${user.name}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Email: ${user.email}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Biografia: ${user.bio}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.rating == 0.0
                                ? 'No ratings yet'
                                : 'Rating: ${user.rating}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Edit your profile',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
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
                              updateEmail(userEmailController.text);
                              updatePassword(passwordController.text);
                              updateUserInfo(user).then((result) {
                                if (result == 'success') {
                                  setState(() {
                                    String updatedName =
                                        userNameController.text;
                                    String updatedEmail =
                                        userEmailController.text;
                                    String updatedBio = userBioController.text;

                                    userNameController.text = updatedName;
                                    userEmailController.text = updatedEmail;
                                    userBioController.text = updatedBio;
                                  });
                                  Navigator.of(context).pop(true);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Erro ao atualizar o perfil")),
                                  );
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          /* EXTRACT TO REQUEST LOGIC */
                          // Display the list of requests
                          if (isLoadingRequests)
                            const CircularProgressIndicator()
                          else if (requests.isEmpty)
                            Center(
                              child: Text(
                                'No Pending Requests',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Pending Requests',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                for (int i = 0; i < requests.length; i++)
                                  ListTile(
                                    leading: CircleAvatar(
                                      // Display user image
                                      backgroundImage:
                                          AssetImage(requestUsers[i].image),
                                      //RangeError (index): Index out of range: no indices are valid: 0
                                    ),

                                    title: Text(requestUsers[i]
                                        .name), // Display user name
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.check),
                                          onPressed: () async {
                                            try {
                                              // Call rejectRequest function
                                              await FirebaseRequestRepo()
                                                  .acceptRequest(
                                                      requests[i].id);
                                              setState(() {
                                                requests.removeAt(i);
                                              });
                                            } catch (error) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Failed to reject request: $error")),
                                              );
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () async {
                                            try {
                                              // Call rejectRequest function
                                              await FirebaseRequestRepo()
                                                  .rejectRequest(
                                                      requests[i].id);
                                              // Remove the rejected request from the list
                                              setState(() {
                                                requests.removeAt(i);
                                              });
                                            } catch (error) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Failed to reject request: $error")),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          /* -----------------ENDS HERE----------------- */
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  /* EXTRACT TO REQUEST LOGIC */
  Future<void> fetchUnansweredRequests() async {
    try {
      ProductRepo productRepo = FirebaseProductRepo();
      List<Product> productss = await productRepo.getProducts();
      RequestRepo requestRepo = FirebaseRequestRepo();
      List<Request> requestss = await requestRepo.getRequests();

      for (Product p in productss) {
        if (p.userId != FirebaseAuth.instance.currentUser?.uid) {
          continue;
        } else {
          for (Request r in requestss) {
            if (p.id == r.productId && !r.accepted) {
              requests.add(r);
            }
          }
        }
      }
      await fillRequestUsers();
    } finally {
      // Set isLoadingRequests to false once requests are loaded or an error occurs
      setState(() {
        isLoadingRequests = false;
      });
    }
  }

  Future<MyUser> getRequesterInfo(Request r) async {
    try {
      String uid = r.fromUserId;
      MyUser user = await FirebaseUserRepo().getUser(uid);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fillRequestUsers() async {
    try {
      for (Request r in requests) {
        requestUsers.add(await getRequesterInfo(r));
      }
      //print("This is ${requestUsers}"); print("This is ${requests}");
    } catch (error) {
      rethrow;
    }
  }

  /* -----------------ENDS HERE----------------- */

  pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    const Text('No image selected');
  }

  void selectImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      photo = file;
    });
  }

  void reauthenticateUser(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);
      // Agora você pode realizar operações sensíveis, como atualizar o e-mail ou a senha
    } catch (e) {
      rethrow;
    }
  }

// Função para atualizar o e-mail do usuário
  void updateEmail(String newEmail) async {
    try {
      // Obtenha a instância do FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;

      // Verifique se há um usuário autenticado
      User? user = auth.currentUser;
      if (user != null) {
        // Atualize o e-mail do usuário
        await user.verifyBeforeUpdateEmail(newEmail);
      } else {
        // Se não houver usuário autenticado, exiba uma mensagem de erro
      }
    } catch (e) {
      // Se ocorrer algum erro, exiba a mensagem de erro
    }
  }

// Função para atualizar a senha do usuário
  void updatePassword(String newPassword) async {
    try {
      // Obtenha a instância do FirebaseAuth
      FirebaseAuth auth = FirebaseAuth.instance;

      // Verifique se há um usuário autenticado
      User? user = auth.currentUser;
      if (user != null) {
        // Atualize a senha do usuário
        await user.updatePassword(newPassword);
      } else {
        // Se não houver usuário autenticado, exiba uma mensagem de erro
      }
    } catch (e) {
      // Se ocorrer algum erro, exiba a mensagem de erro
    }
  }

  Future<String> updateUserInfo(MyUser user) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      String name = user.name;
      String email = user.email;
      String bio = user.bio;
      String password = passwordController.text;

      if (userNameController.text.isNotEmpty) name = userNameController.text;
      if (userEmailController.text.isNotEmpty) name = userEmailController.text;
      if (userBioController.text.isNotEmpty) name = userBioController.text;

      if (userId.isNotEmpty &&
          (name.isNotEmpty ||
              email.isNotEmpty ||
              bio.isNotEmpty ||
              photo != null)) {
        String imageUrl = user.image;
        if (photo != null) {
          imageUrl = await uploadImageToStorage('userImage_$userId', photo!);
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'name': name,
          'email': email,
          'bio': bio,
          'image': imageUrl,
        });

        reauthenticateUser(email, password);

        await FirebaseAuth.instance.currentUser?.reload();
        await Future.delayed(const Duration(seconds: 2));
        return 'success';
      } else {
        return 'Please provide at least one field to update.';
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String imagePath, Uint8List file) async {
    Reference ref = _storage.ref().child(imagePath);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
