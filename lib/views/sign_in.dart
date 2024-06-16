import 'package:ecosecha_app/components/items/custom_button.dart';
import 'package:ecosecha_app/components/items/custom_formfield.dart';
import 'package:ecosecha_app/components/items/custom_header.dart';
import 'package:ecosecha_app/components/items/custom_richtext.dart';
import 'package:ecosecha_app/controller/auth_controller.dart';
import 'package:ecosecha_app/controller/aux_controller.dart';
import 'package:ecosecha_app/styles/app_colors.dart';
import 'package:ecosecha_app/views/forget_password_screen.dart';
import 'package:ecosecha_app/views/onboard.dart';
import 'package:ecosecha_app/views/sign_up.dart';
import 'package:ecosecha_app/views/sign_up_owner.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  bool _obscureText = true;
  String? _errorTextPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.blue,
          ),
          CustomHeader(
            text: 'Iniciar Sesión',
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardScreen()));
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.whiteshade,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09),
                        child: const CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipOval(
                                child: Image(
                                  image: AssetImage('assets/ecosecha_logo.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                      headingText: "Correo Electrónico",
                      hintText: "ejemploentrega@gmail.com",
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: _emailController,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      headingText: "Contraseña",
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "Al menos 8 caracteres",
                      obsecureText: _obscureText,
                      suffixIcon: IconButton(
                          icon: _obscureText
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }),
                      controller: _passwordController,
                      errorText: _errorTextPassword,
                      onChanged: (value) {
                        setState(() {
                          _errorTextPassword = (AuxController()
                                  .isPasswordLengthValid(value))
                              ? 'La contraseña debe tener al menos 8 caracteres'
                              : null;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetScreen()));
                            },
                            child: Text(
                              "¿Olvidaste tu contraseña?",
                              style: TextStyle(
                                  color: AppColors.blue.withOpacity(0.7),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AuthButton(
                      onTap: () {
                        AuthController().signInUser(context, email, password);
                      },
                      text: 'Iniciar Sesión',
                    ),
                    CustomRichText(
                      discription: "¿No tienes una cuenta? ",
                      text: "Regístro de Usuario",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                    ),
                    CustomRichText(
                      discription: "",
                      text: "Regístro de Campesino",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpOwner()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
