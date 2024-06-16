// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'dart:io';
import 'package:ecosecha_app/components/items/custom_formfield.dart';
import 'package:ecosecha_app/components/nav_bar_owner.dart';
import 'package:ecosecha_app/controller/alert_dialog.dart';
import 'package:ecosecha_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:raised_buttons/raised_buttons.dart';

class FoodRegister extends StatefulWidget {
  const FoodRegister({super.key});

  @override
  _FoodRegisterState createState() => _FoodRegisterState();
}

class _FoodRegisterState extends State<FoodRegister> {
  late XFile sampleImage = XFile('');
  final formKey = GlobalKey<FormState>();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController preparationTimeController =
      TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de alimento"),
        centerTitle: true,
      ),
      body: enableUpload(),
      bottomNavigationBar: const NavBarOwner(),
    );
  }

  Future getImage() async {
    try {
      var tempImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (tempImage != null) {
        setState(() {
          sampleImage = XFile(tempImage.path);
          print("Hola ${sampleImage.path}");
        });
      }
    } catch (e) {
      showPersonalizedAlert(
          context, "Error inesperado", AlertMessageType.error);
    }
  }

  Widget enableUpload() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            CustomFormField(
                headingText: "Alimento",
                hintText: "Ejemplo: Mango",
                obsecureText: false,
                suffixIcon: const Icon(Icons.food_bank_rounded),
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.done,
                controller: productController,
                maxLines: 1),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Cantidad",
                hintText: "Ejemplo: 12",
                obsecureText: false,
                suffixIcon: const Icon(Icons.unfold_more_double_sharp),
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: quantityController,
                maxLines: 1),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Precio",
                hintText: "Ejemplo: 12000",
                obsecureText: false,
                suffixIcon: const Icon(Icons.monetization_on_outlined),
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: priceController,
                maxLines: 1),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Categoría",
                hintText: "Ejemplo: Frutas",
                obsecureText: false,
                suffixIcon: const Icon(Icons.category_rounded),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: categoryController,
                maxLines: 1),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Tiempo de preparación",
                hintText: "Ejemplo: 30 minutos",
                obsecureText: false,
                suffixIcon: const Icon(Icons.timelapse_outlined),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: preparationTimeController,
                maxLines: 1),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Descripción",
                hintText: "Ejemplo: Mango fresco de la región",
                obsecureText: false,
                suffixIcon: const Icon(Icons.description),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                maxLines: 10),
            const SizedBox(height: 16.0),
            const Text("Agrega una imagen del alimento"),
            if (sampleImage.path.isNotEmpty)
              Image.file(
                File(sampleImage.path),
                height: 300,
                width: 600,
              ),
            const SizedBox(height: 16.0),
            IconButton(
                onPressed: () {
                  getImage();
                },
                icon: const Icon(Icons.add_a_photo)),
            const SizedBox(height: 16.0),
            RaisedButtons(
              GlobalKey<FormState>(),
              text: "Guardar",
              onPressed: () {
                validateAndSave();
                //Navigator.pop(context);
                setState(() {
                  productController.clear();
                  quantityController.clear();
                  descriptionController.clear();
                  priceController.clear();
                  categoryController.clear();
                  preparationTimeController.clear();
                  sampleImage = XFile('');
                });
              },
              fontSize: 18,
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  void validateAndSave() {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      ProductController().registerProduct(
          context,
          productController.text,
          quantityController.text,
          priceController.text,
          categoryController.text,
          preparationTimeController.text,
          descriptionController.text,
          sampleImage);
    } else {
      showPersonalizedAlert(
          context, "Error inesperado", AlertMessageType.error);
    }
  }
}
