// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:ecosecha_app/components/animation/ScaleRoute.dart';
import 'package:ecosecha_app/components/items/custom_formfield.dart';
import 'package:ecosecha_app/components/nav_bar_owner.dart';
import 'package:ecosecha_app/model/product.dart';
import 'package:ecosecha_app/views/home_owner.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class ProductShow extends StatefulWidget {
  const ProductShow({super.key, required this.product});
  final Product product;
  @override
  _ProductShowState createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController preparationTimeController =
      TextEditingController();
  late final String image;

  @override
  void initState() {
    productController.text = widget.product.productName;
    quantityController.text = widget.product.productQuantity.toString();
    descriptionController.text = widget.product.description;
    priceController.text = widget.product.productPrice.toString();
    categoryController.text = widget.product.category;
    preparationTimeController.text = widget.product.preparationTime;
    image = widget.product.productImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informacion del producto"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF3a3737),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, ScaleRoute(page: const HomeScreenOwner()));
          },
        ),
      ),
      body: productData(),
      bottomNavigationBar: const NavBarOwner(),
    );
  }

  Widget productData() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            CustomFormField(
                headingText: "Producto",
                hintText: "Ejemplo: Yuca",
              obsecureText: false,
              suffixIcon: const Icon(Icons.food_bank_rounded),
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.done,
              controller: productController,
              maxLines: 1,
              readOnly: true,
            ),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Cantidad en kg",
                hintText: "Ejemplo: 12",
                obsecureText: false,
                suffixIcon: const Icon(Icons.unfold_more_double_sharp),
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: quantityController,
                maxLines: 1,
                readOnly: true),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Precio por kg",
                hintText: "Ejemplo: 12000",
                obsecureText: false,
                suffixIcon: const Icon(Icons.monetization_on_outlined),
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: priceController,
                maxLines: 1,
                readOnly: true),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Categoría",
                hintText: "Ejemplo: Tuberculos",
                obsecureText: false,
                suffixIcon: const Icon(Icons.category_rounded),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: categoryController,
                maxLines: 1,
                readOnly: true),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Tiempo de cosechado",
                hintText: "Ejemplo: 1 dias(0 dias si no se ha cosechado)",
                obsecureText: false,
                suffixIcon: const Icon(Icons.timelapse_outlined),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: preparationTimeController,
                maxLines: 1,
                readOnly: true),
            const SizedBox(height: 16.0),
            CustomFormField(
                headingText: "Descripción",
                hintText: "Ejemplo: Yuca fresca de la mejor calidad",
                obsecureText: false,
                suffixIcon: const Icon(Icons.description),
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                maxLines: 10,
                readOnly: true),
            const SizedBox(height: 16.0),
            Image.network(
              image,
              height: 300,
              width: 350,
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
