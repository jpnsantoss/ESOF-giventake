import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/product/blocs/bloc/upload_product_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  void initState() {
    super.initState();
  }

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
    return BlocProvider(
      create: (context) => UploadProductBloc(),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Upload product'),
      ),
      body: BlocBuilder<UploadProductBloc, UploadProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
      child: Center(
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
                onTap: selectImage, /*(){context.read<UploadProductBloc>().add(PickImageEvent(ImageSource.gallery));},*/
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
                  context.read<UploadProductBloc>().add(
                            UploadNewProductEvent(
                              
                              productDescriptionController.text,
                              productLocationController.text,
                              productTitleController.text,
                              photo,
                            ),
                          );

                          Navigator.of(context).pop(true);
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

}
