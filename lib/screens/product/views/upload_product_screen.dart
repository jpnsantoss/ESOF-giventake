import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productLocationController =
      TextEditingController();
  final TextEditingController productImageController = TextEditingController();

  

  @override
  void dispose() {
    productTitleController.dispose();
    productDescriptionController.dispose();
    productLocationController.dispose();
    super.dispose();
  }

  Uint8List? photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                controller: productTitleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Title',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: productLocationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Location',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: productDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  saveProduct().then((result) {
                    if (result == 'sucess') {
                      Navigator.of(context).pop(true);
                    }
                  });

                  /*Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));*/
                  //Navigator.of(context).pop(true);
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
          ),
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
    print('File selected: $file');
    setState(() {
      photo = file;
    });
  }

  Future<String> saveProduct() async {
    String title = productTitleController.text;
    String location = productLocationController.text;
    String description = productDescriptionController.text;

    String resp = await saveProductToFirestore(
        title: title,
        location: location,
        description: description,
        file: photo!);
    return resp;
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImageToStorage(String imagePath, Uint8List file) async {
    Reference ref = _storage.ref().child(imagePath);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveProductToFirestore(
      {required String title,
      required String location,
      required String description,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String id = const Uuid().v4();

      if (title.isNotEmpty ||
          location.isNotEmpty ||
          description.isNotEmpty ||
          file.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('productImage', file);
        await _firestore.collection('products').add({
          'id': id,
          'userId': userId,
          'title': title,
          'location': location,
          'description': description,
          'image': imageUrl,
        });

        res = 'sucess';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
