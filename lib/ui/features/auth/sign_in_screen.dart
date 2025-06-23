import 'dart:ui';

import 'package:crowfunding_project/core/constants/nav_ids.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/navigation/base_controller.dart';
import 'package:crowfunding_project/navigation/base_screen.dart';
import 'package:crowfunding_project/services/auth_service.dart';
import 'package:crowfunding_project/ui/features/auth/auth_viewmodel.dart';
import 'package:crowfunding_project/utils/custom_label.dart';
import 'package:crowfunding_project/utils/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthViewmodel _authViewmodel = Get.find<AuthViewmodel>();
  final AuthService _authService = Get.find<AuthService>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      _authViewmodel.signInState.value = UiStateLoading();
      final result = await _authViewmodel.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (result is UiStateSuccess<UserCredential>) {
        await _authService.handleSignIn(result.data.user!);
        Get.back();
      }
    } catch (e) {
      _authViewmodel.signInState.value = UiStateError(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la connexion : ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/bg_sign_in.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                            _authViewmodel.signOutUsecase;
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Text(
                          'Connectez-vous à votre compte',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: _sigmaX,
                                sigmaY: _sigmaY,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(_opacity),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomLabel(
                                          label: 'Email',
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('emailField'),
                                          controller: _emailController,
                                          contentRequired: true,
                                          hint: 'Entrez votre email',
                                          keyBoardType: 'email',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez entrer votre email';
                                            }
                                            if (!RegExp(
                                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                            ).hasMatch(value)) {
                                              return 'Veuillez entrer un email valide';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        CustomLabel(
                                          label: 'Mot de passe',
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('passwordField'),
                                          controller: _passwordController,
                                          contentRequired: true,
                                          hint: 'Entrez votre mot de passe',
                                          obscureText: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez entrer votre mot de passe';
                                            }
                                            if (value.length < 6) {
                                              return 'Le mot de passe doit contenir au moins 6 caractères';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              // Logic to navigate to password recovery
                                            },
                                            child: const Text(
                                              'Mot de passe oublié ?',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ElevatedButton(
                                          key: const Key('signInButton'),
                                          onPressed: _signIn,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Obx(() {
                                              final state = _authViewmodel.signInState.value;

                                             if (state == null) {
                                                return const Text(
                                                  'Se Connecter',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              } else if (state is UiStateLoading) {
                                                return const Center(
                                                  child: CircularProgressIndicator(color: Colors.white),
                                                );
                                              } else {
                                                return const Text(
                                                  'Se connecter',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              }
                                            }),
                                        ),
                                        const SizedBox(height: 16),
                                        const Row(
                                          children: [
                                            Expanded(
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 1.5,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Text(
                                                'OU',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        OutlinedButton.icon(
                                          key: const Key('signInGoogleButton'),
                                          onPressed: () {
                                            // Logic to sign in with Google
                                          },
                                          icon: Image.asset(
                                            'assets/logos/logo_google.png',
                                            height: 20,
                                          ),
                                          label: const Text(
                                            'Continuer avec Google',
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        OutlinedButton.icon(
                                          key: const Key(
                                            'signInFacebookButton',
                                          ),
                                          onPressed: () {
                                            // Logic to sign in with Facebook
                                          },
                                          icon: Image.asset(
                                            'assets/logos/logo_facebook.png',
                                            height: 20,
                                          ),
                                          label: const Text(
                                            'Continuer avec Facebook',
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Vous n\'avez pas de compte ?',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed('/role-selection');
                                              },
                                              child: const Text(
                                                ' S\'inscrire',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
