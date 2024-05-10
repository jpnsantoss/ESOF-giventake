import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/components/my_text_field.dart';
import 'package:giventake/screens/profile/blocs/bloc/edit_user_info_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;
  final MyUserEntity user;
  
  const EditProfileScreen({Key? key, required this.userId, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}


class _EditProfileScreenState extends State<EditProfileScreen> {
  late String userId;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userBioController =
      TextEditingController();
  final TextEditingController userImageController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  
  

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
  }

  @override
  void dispose() {
    userNameController.dispose();
    userBioController.dispose();
    super.dispose();
  }

  Uint8List? photo;
@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditUserInfoBloc(userId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body:
         BlocBuilder<EditUserInfoBloc, EditUserInfoState>(
          builder: (context, state) {
            return SingleChildScrollView(
            
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [

                Container(
                height: 200,
                width: 200,
                child: photo != null
                  ? Image.memory(
                      photo!,
                      fit: BoxFit.cover,
                    )
                  : 
                
                Image.network(widget.user.image,
                fit: BoxFit.cover),
                
                ),     
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: selectImage, /*(){context.read<EditUserInfoBloc>().add(PickImageUserEvent(ImageSource.gallery));
                  if(state is EditUserInfoSuccess){
                    photo = state.photo;
                  }},*/
                  child: Text(
                    'Change Photo',
                    style: TextStyle(
                    color: Colors.blue, // Define a cor do texto como azul
                    decoration: TextDecoration.underline, // Adiciona uma linha por baixo do texto
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
                      color: Colors.grey.withOpacity( 0.5), 
                      spreadRadius: 3,
                      blurRadius:7,
                     offset: const Offset(0, 3),       
                    ),
              ],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [                                      
                                          Text('Nome: ${widget.user.name}',
                                              style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.left,),
                                             const SizedBox(height: 4),
                                             Text('Email: ${widget.user.email}',
                                             style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.left,),
                                            const SizedBox(height: 4),
                                             Text('Biografia: ${widget.user.bio}',
                                             style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.left,),
                                            const SizedBox(height: 4),
                                            Text(
                                                  widget.user!.rating == 0.0
                                                  ? 'No ratings yet'
                                                  : 'Rating: ${widget.user.rating}',
                                                  style: TextStyle(
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
                  children: [TextFormField(
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
                TextFormField(
                  controller: oldEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Old email',
                    hintText: 'old email',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: newEmailController,
                  decoration: const InputDecoration(
                    labelText: 'New email',
                    hintText: 'email',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                 TextFormField(
                  controller: oldPasswordController,
                  obscureText: true, // Configura para mostrar bolinhas em vez de letras
                  decoration: InputDecoration(
                    labelText: 'Old Password',
                    hintText: 'Enter old password',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(CupertinoIcons.lock_fill),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter new password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(CupertinoIcons.lock_fill),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassword = CupertinoIcons.eye_fill;
                            } else {
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (val) {
                      if (val!.contains(RegExp(r'[A-Z]'))) {
                                    setState(() {
                                      containsUpperCase = true;
                                    });
                                  } else {
                                    setState(() {
                                      containsUpperCase = false;
                                    });
                                  }
                                  if (val.contains(RegExp(r'[a-z]'))) {
                                    setState(() {
                                      containsLowerCase = true;
                                    });
                                  } else {
                                    setState(() {
                                      containsLowerCase = false;
                                    });
                                  }
                                  if (val.contains(RegExp(r'[0-9]'))) {
                                    setState(() {
                                      containsNumber = true;
                                    });
                                  } else {
                                    setState(() {
                                      containsNumber = false;
                                    });
                                  }
                                  if (val.contains(RegExp(
                                      r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                                    setState(() {
                                      containsSpecialChar = true;
                                    });
                                  } else {
                                    setState(() {
                                      containsSpecialChar = false;
                                    });
                                  }
                                  if (val.length >= 8) {
                                    setState(() {
                                      contains8Length = true;
                                    });
                                  } else {
                                    setState(() {
                                      contains8Length = false;
                                    });
                                  }
                                  return null;
                    },
                    validator: (val) {
                    if (val!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                                      .hasMatch(val)) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                    },
                  ),
                ),

                



                ElevatedButton(
                  onPressed: () async {
                    
                   changePassword(oldEmailController.text, newEmailController.text, oldPasswordController.text ,newPasswordController.text);
                  
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Change password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    
                    context.read<EditUserInfoBloc>().add(
                            UpdateUserInfoEvent(
                              userId,
                              userNameController.text,
                              userBioController.text,
                              photo,
                            ),
                          );

                          Navigator.of(context).pop(true);
                  
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
                ],
                ),
                ),
              ],
              ),
            ),
            
            );
          },
        ),
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
    setState(() {
      photo = file;
    });
  }

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  

  void changePassword(oldEmail, newEmail, oldPassword, newPassword) async {
    var cred = EmailAuthProvider.credential(email: oldEmail, password: oldPassword);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });

   
  }

} 
