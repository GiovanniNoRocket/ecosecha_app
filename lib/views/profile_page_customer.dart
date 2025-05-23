// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'dart:async';

import 'package:ecosecha_app/components/display_image_widget.dart';
import 'package:ecosecha_app/components/nav_bar_customer.dart';
import 'package:ecosecha_app/components/profile/edit_address.dart';
import 'package:ecosecha_app/components/profile/edit_email.dart';
import 'package:ecosecha_app/components/profile/edit_image.dart';
import 'package:ecosecha_app/components/profile/edit_last_name.dart';
import 'package:ecosecha_app/components/profile/edit_name.dart';
import 'package:ecosecha_app/components/profile/edit_phone.dart';
import 'package:ecosecha_app/controller/person_controller.dart';
import 'package:ecosecha_app/views/home_customer.dart';
import 'package:flutter/material.dart';

class ProfilePageCustomer extends StatefulWidget {
  const ProfilePageCustomer({super.key});

  @override
  _ProfilePageCustomerState createState() => _ProfilePageCustomerState();
}

class _ProfilePageCustomerState extends State<ProfilePageCustomer> {
  late Future<List<String>> userInfo;

  @override
  void initState() {
    userInfo = PersonController().getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar perfil',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(64, 105, 225, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF3a3737),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreenCustomer()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<String>>(
              future: userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Muestra un indicador de carga mientras se obtiene la información
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // Muestra un mensaje de error si hay algún problema
                  print('Error: ${snapshot.error}');
                  return const Text("Unexpected error");
                } else {
                  // Muestra la información del usuario si la operación fue exitosa
                  List<String> userInfoList = snapshot.data!;
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateSecondPage(EditImagePage(
                            image: userInfoList[5],
                          ));
                        },
                        child: DisplayImage(
                          imagePath: userInfoList[
                              5], // Asegúrate de usar el índice correcto
                          onPressed: () {},
                        ),
                      ),
                      buildUserInfoDisplay(
                          userInfoList[0], 'Nombre', const EditNameFormPage()),
                      buildUserInfoDisplay(userInfoList[1], 'Apellidos',
                          const EditLastNameFormPage()),
                      buildUserInfoDisplay(
                          userInfoList[2], 'Teléfono', const EditPhoneFormPage()),
                      buildUserInfoDisplay(
                          userInfoList[3], 'Correo electrónico', const EditEmailFormPage()),
                      buildUserInfoDisplay(userInfoList[4], 'Dirección',
                          const EditAddressFormPage()),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBarCustomer(),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(editPage);
                      },
                      child: Text(
                        getValue,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {
                      navigateSecondPage(editPage);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 40.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  FutureOr onGoBack(dynamic value) {
    // Actualiza la información del usuario cuando se vuelve de la página de edición
    setState(() {
      userInfo = PersonController().getProfileData();
    });
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
