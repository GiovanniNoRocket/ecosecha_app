// ignore_for_file: use_build_context_synchronously

import 'package:ecosecha_app/components/appbar_widget.dart';
import 'package:ecosecha_app/controller/customer_controller.dart';
import 'package:ecosecha_app/controller/owner_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({super.key});

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
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
                  width: 330,
                  child: Text(
                    "¿Cómo te llamas?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese su nombre';
                              } else if (!isAlpha(value)) {
                                return 'Sólo letras, por favor';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Primer nombre'),
                            controller: firstNameController,
                          ))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for Last Name
                            /*validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your second name';
                              } else if (!isAlpha(value)) {
                                return 'Only Letters Please';
                              }
                              return null;
                            },*/
                            decoration:
                                const InputDecoration(labelText: 'Segundo nombre'),
                            controller: secondNameController,
                          )))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate() &&
                                isAlpha(firstNameController.text  +
                                    secondNameController.text)) {
                              final uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              String? ownerId =
                                  await OwnerController().getOwnerId();
                              if (uid != ownerId) {
                                CustomerController().updateName(
                                    "${firstNameController.text} ${secondNameController.text}",
                                    uid);
                              } else {
                                OwnerController().updateName(
                                    "${firstNameController.text} ${secondNameController.text}",
                                    uid);
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
            ],
          ),
        ));
  }
}
