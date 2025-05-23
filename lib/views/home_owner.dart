// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print

import 'package:ecosecha_app/components/SearchWidget.dart';
import 'package:ecosecha_app/components/drawer/custom_drawer_owner.dart';
import 'package:ecosecha_app/components/items/custom_image.dart';
import 'package:ecosecha_app/components/nav_bar_owner.dart';
import 'package:ecosecha_app/controller/product_controller.dart';
import 'package:ecosecha_app/model/product.dart';
import 'package:ecosecha_app/styles/app_colors.dart';
import 'package:ecosecha_app/views/notification.dart';
import 'package:ecosecha_app/views/product_show.dart';
import 'package:ecosecha_app/views/product_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenOwner extends StatefulWidget {
  const HomeScreenOwner({super.key});

  @override
  _HomeScreenOwnerState createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  late List<Product> products = [];

  @override
  void initState() {
    super.initState();
    // Cargar productos al inicializar la página
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      List<Product> fetchedProducts =
          await ProductController().getProductDetails(uid);
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Error al cargar los productos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cargar productos cada vez que se llega a la página
    _loadProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: const CustomDrawerOwner(),
      body: _buildBody(),
      bottomNavigationBar: const NavBarOwner(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "¿Qué te gustaría agregar?",
        style: TextStyle(
          color: Color(0xFF3a3737),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Color(0xFF3a3737),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()));
          },
        )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchWidget(),
          const SizedBox(height: 25),
          _buildAdsImage(),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Productos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          _buildProductsList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAdsImage() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/Home.jpeg'),
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    if (products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        for (var product in products) _cardProduct(product),
      ],
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage(
            product.productImage,
            width: 60,
            height: 60,
            radius: 10,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  product.productPrice.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 3),
                Text(
                  product.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductShow(
                            product: product,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.visibility_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductUpdate(
                            product: product,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      ProductController().deleteProduct(product);
                      //setState(() {});
                    },
                    icon: const Icon(Icons.delete_forever),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
