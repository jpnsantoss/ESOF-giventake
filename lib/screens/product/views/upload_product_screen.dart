//import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
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
  final TextEditingController productImageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
            child: photo != null ? Image.memory(photo!, fit:BoxFit.cover,) : Column(
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
              decoration: InputDecoration(labelText: 'Title',
              hintText: 'Title',
              contentPadding: EdgeInsets.all(10),
              border:OutlineInputBorder(),),
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
                saveProduct();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                
                /*if (photo != null) {
                    // Upload da imagem para o Firebase Storage
                    //String imageURL = await uploadImageToStorage(photo!.path);

                    String title = productTitleController.text;
                    String location = productLocationController.text;
                    String description = productDescriptionController.text;

                    String resp = await saveProductToFirestore(title: title, location: location, description: description, file: photo!);
                    // Salvar os dados do produto no Firestore, incluindo a URL da imagem
                    
                    
                    // Limpar os campos após o upload bem-sucedido
                    productTitleController.clear();
                    productDescriptionController.clear();
                    productLocationController.clear();
                  }*/
                //uploadProductToFirebase();
                  
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
  

pickImage(ImageSource source) async{
  final ImagePicker picker = ImagePicker();
  XFile? _file = await picker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print('No image selected');
}

  void selectImage() async{
  //final ImagePicker picker = ImagePicker();

  
    Uint8List file = await pickImage(ImageSource.gallery);
    print('File selected: $file');
    if (file != null) {
      setState(() {
        photo = file;
      });
    }
}

void saveProduct() async {
  String title = productTitleController.text;
  String location = productLocationController.text;
  String description = productDescriptionController.text;

  String resp = await saveProductToFirestore(title: title, location: location, description: description, file: photo!);
}

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> uploadImageToStorage(String imagePath,Uint8List file) async {
  Reference ref =_storage.ref().child(imagePath);
  UploadTask uploadTask =ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
    /*File file = File(imagePath);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');
    firebase_storage.UploadTask uploadTask = ref.putFile(file);
    firebase_storage.TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();*/
  }

Future<String> saveProductToFirestore({required String title, required String location, required String description, required Uint8List file }) async{
    String res= "Some error occurred";
    try{
      if(title.isNotEmpty || location.isNotEmpty || description.isNotEmpty ||file.isNotEmpty){

      String imageUrl = await uploadImageToStorage('productImage', file);
      await _firestore.collection('products').add({
        'title' : title,
        'location' : location,
        'description' : description,
        'imageLink' : imageUrl,
      });

      res='sucess';
    }
    }
    catch(err){
      res=err.toString();
    }
    return res;
    /*String title = productTitleController.text;
    String description = productDescriptionController.text;
    String location = productLocationController.text;
    
    Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'location': location,
      'imageURL': imageURL, // URL da imagem no Firebase Storage
    };

    FirebaseFirestore.instance.collection('products').add(productData)
      .then((value) {
        print('Product uploaded successfully');
      })
      .catchError((error) {
        print('Error uploading product: $error');
      });*/
  }

  /*void uploadProductToFirebase() {
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
}*/

}