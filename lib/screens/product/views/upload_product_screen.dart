import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:product_repository/src/firebase_product_repo.dart';
import 'package:giventake/components/my_text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
   final _formKey = GlobalKey<FormState>();

@override
  void dispose() {
    // Dispose dos controladores de texto para liberar recursos
    productTitleController.dispose();
    productDescriptionController.dispose();
    super.dispose();
  }


void uploadProductToFirebase() {
  // Recupere os valores dos controladores de texto
  String productTitle = productTitleController.text;
  String productDescription = productDescriptionController.text;

  // Crie um mapa com os detalhes do produto
  Map<String, dynamic> productData = {
    'tile': productTitle,
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
      
    })
    .catchError((error) {
      // Trate qualquer erro que ocorra durante o envio do produto
      print('Erro ao enviar produto: $error');
    });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload de Produto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campos de entrada para detalhes do produto
            
            TextFormField(
              controller: productTitleController,
              decoration: InputDecoration(labelText: 'Título do Produto'),
            ),
            TextFormField(
              controller: productDescriptionController,
              decoration: InputDecoration(labelText: 'Descrição do Produto'),
            
            ),
            ElevatedButton(
                onPressed: () {
                  // Adicione aqui a lógica para enviar os dados do produto para o Firebase
                  // Por exemplo, você pode chamar um método que envie os dados do produto para o Firestore
                  uploadProductToFirebase();
                },
                child: Text('Enviar Produto'),
              ),
            // Outros campos de entrada para outros detalhes do produto, se necessário
            // Botão para enviar o produto
            // Campos de entrada para detalhes do produto
            // Botão para enviar o produto
          ],
        ),
      ),
    );
  }
}