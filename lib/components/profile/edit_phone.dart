// ignore_for_file: use_build_context_synchronously

import 'package:ecosecha_app/components/appbar_widget.dart';
import 'package:ecosecha_app/controller/customer_controller.dart';
import 'package:ecosecha_app/controller/owner_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({super.key});
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 320,
                    child: Text(
                      "¿Cuál es su número de teléfono?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduzca su número de teléfono';
                            } else if (isAlpha(value)) {
                              return 'Solo números por favor';
                            } else if (value.length < 10) {
                              return 'Por favor, ingrese un número de teléfono valido';
                            }
                            return null;
                          },
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Su número de teléfono',
                          ),
                        ))),
                Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  isNumeric(phoneController.text)) {
                                final uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                String? ownerId =
                                    await OwnerController().getOwnerId();
                                if (uid != ownerId) {
                                  CustomerController()
                                      .updatePhone(phoneController.text, uid);
                                } else {
                                  OwnerController()
                                      .updatePhone(phoneController.text, uid);
                                }
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Guardar',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
