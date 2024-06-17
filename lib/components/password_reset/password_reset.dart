import 'package:ecosecha_app/components/items/custom_button.dart';
import 'package:ecosecha_app/controller/auth_controller.dart';
import 'package:ecosecha_app/controller/aux_controller.dart';
import 'package:ecosecha_app/styles/app_colors.dart';
import 'package:ecosecha_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  AuxController.validateEmail(value) == false) {
                return 'Por favor, ingresa un correo electrónico válido';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Correo electrónico",
              hintStyle: KTextStyle.font14Hint500Weight,
              filled: true,
              fillColor: AppColors.lightShadeOfGray,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.gray93Color,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.mainBlue,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          AuthButton(
              onTap: () {
                AuthController()
                    .sendEmailResetPassword(emailController.text, context);
              },
              text: "Restablecer")
        ],
      ),
    );
  }
}
