import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:product_repository/src/firebase_product_repo.dart';
import 'package:giventake/components/my_text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giventake/screens/home/views/home_screen.dart';
import 'package:giventake/app_view.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:giventake/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class ProductUploadScreen extends StatefulWidget {
  
  const ProductUploadScreen({Key? key}) : super(key: key);

  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productLocationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

@override
  void dispose() {
    productTitleController.dispose();
    productDescriptionController.dispose();
    productLocationController.dispose();
    super.dispose();
  }


void uploadProductToFirebase() {
  String productTitle = productTitleController.text;
  String productDescription = productDescriptionController.text;
  String productLocation = productLocationController.text;

  Map<String, dynamic> productData = {
    'title': productTitle,
    'location': productLocation,
    'description': productDescription,
  };

   FirebaseFirestore.instance.collection('products').add(productData)
    .then((value) {
      print('Produto enviado com sucesso!');
      productTitleController.clear();
      productDescriptionController.clear();
      productLocationController.clear();
      
    })
    .catchError((error) {
      print('Erro ao enviar produto: $error');
    });
}

  XFile? photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Add a new product'),
      ),
     body: Center(

      child: Padding(
        padding: EdgeInsets.all(16.0), // Espaçamento ao redor de todos os elementos
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda dos elementos
          children: [
            Text('Add a new product',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),),
              SizedBox(height: 30.0),
              GestureDetector(
          onTap: selectImage,
          child: Container(
            width: 200, // Largura do contêiner
            height: 200, // Altura do contêiner
            decoration: BoxDecoration(
              color: Colors.grey[200], // Cor de fundo do contêiner
              borderRadius: BorderRadius.circular(10), // Borda arredondada
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Alinhamento do ícone e do texto ao centro
              children: [
                Icon(
                  Icons.camera_alt, // Ícone da câmera
                  size: 50, // Tamanho do ícone
                  color: Colors.black, // Cor do ícone
                ),
                SizedBox(width: 20), // Espaçamento entre o ícone e o texto
                Text(
                  'Upload an Image', // Texto ao lado do ícone
                  style: TextStyle(
                    fontSize: 18, // Tamanho da fonte do texto
                    color: Colors.black, // Cor do texto
                  ),
                ),
                Text('Use any proper format: PNG, JPG, WEBP, JPEG up to 4MB',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12, // Tamanho da fonte do texto
                    color: Colors.grey, // Cor do texto
                  ),)
              ],
            ),
          ),
        ),
        
            SizedBox(height: 16.0),
            TextFormField(
              controller: productTitleController,
              decoration: InputDecoration(labelText: 'Título do Produto'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: productLocationController,
              decoration: InputDecoration(labelText: 'Localização do Produto'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: productDescriptionController,
              decoration: InputDecoration(labelText: 'Descrição do Produto'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                uploadProductToFirebase();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Padding(
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
  
  selectImage() async {
  final ImagePicker picker = ImagePicker();

  try {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    print('File selected: $file');
    if (file != null) {
      setState(() {
        photo = file;
      });
    }
  } catch (e) {
    print('Error selecting image: $e');
  }
}

}