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
  // Defina os controladores de texto e outras variáveis necessárias
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productLocationController = TextEditingController();
 // File? _imageFile;
   final _formKey = GlobalKey<FormState>();

@override
  void dispose() {
    // Dispose dos controladores de texto para liberar recursos
    productTitleController.dispose();
    productDescriptionController.dispose();
    productLocationController.dispose();
    super.dispose();
  }


void uploadProductToFirebase() {
  // Recupere os valores dos controladores de texto
  String productTitle = productTitleController.text;
  String productDescription = productDescriptionController.text;
  String productLocation = productLocationController.text;

  // Crie um mapa com os detalhes do produto
  Map<String, dynamic> productData = {
    'title': productTitle,
    'location': productLocation,
    'description': productDescription,
  
    // Adicione outros detalhes do produto, se necessário
  };

  // Envie os dados do produto para o Firestore
  // Por exemplo, você pode usar o método 'set' para adicionar um documento com os detalhes do produto
  FirebaseFirestore.instance.collection('products').add(productData)
    .then((value) {
      // Produto enviado com sucesso
      print('Produto enviado com sucesso!');
      // Limpe os campos de entrada após o envio bem-sucedido
      productTitleController.clear();
      productDescriptionController.clear();
      productLocationController.clear();
      
    })
    .catchError((error) {
      // Trate qualquer erro que ocorra durante o envio do produto
      print('Erro ao enviar produto: $error');
    });
}
 late File _selectedImage = File('');
Future<void> _selectImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    // A imagem foi selecionada com sucesso
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  } else {
    // Nenhuma imagem foi selecionada
  }
}

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
             GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedImage == null
                    ? Center(child: Text('Clique para selecionar uma imagem'))
                    : Image.file(_selectedImage),
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
}