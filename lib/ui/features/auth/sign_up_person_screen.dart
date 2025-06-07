import 'dart:ui';

import 'package:crowfunding_project/utils/custom_textformfield.dart';
import 'package:flutter/material.dart';

class SignUpPersonScreen extends StatefulWidget {
  const SignUpPersonScreen({super.key});

  @override
  State<SignUpPersonScreen> createState() => _SignUpPersonScreenState();
}

class _SignUpPersonScreenState extends State<SignUpPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.1;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Handle sign up logic here
      // For example, call an API to create a new user
      // After successful sign up, navigate to the next screen
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
                    'assets/images/bg_sign_up.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: _buildLabel(
                          'Créer un compte',
                          Colors.white,
                          25,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        // First Name
                                        Row(
                                          children: [
                                            _buildLabel('Nom', Colors.white, 16),
                                            const SizedBox(width: 5),
                                            const Text('*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('nameField'),
                                          hint: 'Entrez votre nom',
                                          controller: _firstNameController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          keyBoardType: 'text',
                                        ),
                                        const SizedBox(height: 16),
                                        // Last Name
                                        Row(
                                          children: [
                                            _buildLabel('Prénom', Colors.white, 16),
                                            const SizedBox(width: 5),
                                            const Text('*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('lastNameField'),
                                          hint: 'Entrez votre prénom',
                                          controller: _lastNameController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          keyBoardType: 'text',
                                        ),
                                        const SizedBox(height: 16),     
                                        // Email
                                        Row(
                                          children: [
                                            _buildLabel('Email', Colors.white, 16),
                                            const SizedBox(width: 5),
                                            const Text('*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('emailField'),
                                          hint: 'Entrez votre email',
                                          controller: _emailController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Veuillez entrer l\'email du responsable';
                                            }
                                            final emailRegex = RegExp(
                                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                            );
                                            if (!emailRegex.hasMatch(value)) {
                                              return 'Veuillez entrer un email valide';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        // Password
                                        Row(
                                          children: [
                                            _buildLabel('Mot de passe', Colors.white, 16),
                                            const SizedBox(width: 5),
                                            const Text('*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('passwordField'),
                                          hint: 'Entrez votre mot de passe',
                                          controller: _passwordController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          obscureText: true,
                                          keyBoardType: 'text',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Veuillez entrer un mot de passe';
                                            }
                                            if (value.length < 6) {
                                              return 'Le mot de passe doit contenir au moins 6 caractères';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        // Confirm Password
                                        Row(
                                          children: [
                                            _buildLabel('Confirmer le mot de passe', Colors.white, 16),
                                            const SizedBox(width: 5),
                                            const Text('*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('confirmPasswordField'),
                                          hint: 'Confirmez votre mot de passe',
                                          controller: _confirmPasswordController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          obscureText: true,
                                          keyBoardType: 'text',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Veuillez confirmer votre mot de passe';
                                            }
                                            if (value != _passwordController.text) {
                                              return 'Les mots de passe ne correspondent pas';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                          key: const Key('signUpButton'),
                                          onPressed: _signUp,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text(
                                            'Créer un compte',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
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

  Widget _buildLabel(String label, Color color, double? fontSize) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: color)),
      ],
    );
  }

}