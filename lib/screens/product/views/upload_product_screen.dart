import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giventake/screens/product/blocs/bloc/upload_product_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
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
          title: const Text('Upload product'),
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
                      onTap: selectImage,
                      /*(){context.read<UploadProductBloc>().add(PickImageEvent(ImageSource.gallery));},*/
                      child: Container(
                        width: 400,
                        height: 200,
                        decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.46, color: Color(0x7F818181)),
                        borderRadius: BorderRadius.circular(14.56),
                        ),
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
                                      'Upload an image',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 23.29,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                      ),
                                  ),
                                  SizedBox(height: 10,),
                                  SizedBox(
                                  width: 415.89,
                                  child: Text(
                                  'Use any proper format: PNG, JPG, WEBP, JPEG up to 4MB',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                  color: Color(0xFF818181),
                                  fontSize: 14.56,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  ),
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
                        contentPadding: EdgeInsets.only(top: 12, bottom: 10, left: 5, right: 5), // Ajuste os valores conforme necessário
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true, // Isso alinha o rótulo com o texto de sugestão
                        
                        labelStyle: TextStyle(height: 0), // Isso remove o espaço extra acima do rótulo
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
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.5), // Ajuste o valor conforme necessário
                        ),
                      ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Add Product',
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
        }),
      ),
    );
  }

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
}
