// ignore_for_file: use_build_context_synchronously

import 'package:ecosecha_app/components/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({super.key});

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                        "¿Cuál es tu correo electrónico?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
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
                              return 'Por favor, ingresa tu correo electrónico.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Su dirección de correo electrónico'),
                          controller: emailController,
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
                                  EmailValidator.validate(
                                      emailController.text)) {
                                /*final uid =
                                    FirebaseAuth.instance.currentUser!.uid;
                                String? ownerId =
                                    await OwnerController().getOwnerId();
                                if (uid != ownerId) {
                                  CustomerController()
                                      .updateEmail(emailController.text, uid);
                                } else {
                                  OwnerController()
                                      .updateEmail(emailController.text, uid);
                                }*/
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
