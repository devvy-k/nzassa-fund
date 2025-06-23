import 'dart:ui';

import 'package:crowfunding_project/core/data/models/association_model.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/ui/features/auth/auth_viewmodel.dart';
import 'package:crowfunding_project/utils/custom_label.dart';
import 'package:crowfunding_project/utils/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpAssociationScreen extends StatefulWidget {
  const SignUpAssociationScreen({super.key});

  @override
  State<SignUpAssociationScreen> createState() =>
      _SignUpAssociationScreenState();
}

class _SignUpAssociationScreenState extends State<SignUpAssociationScreen> {
  final AuthViewmodel _authViewmodel = Get.find<AuthViewmodel>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _managerNameController = TextEditingController();
  final TextEditingController _managerEmailController = TextEditingController();
  final TextEditingController _emailAssociationController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.1;

  @override
  void dispose() {
    _nameController.dispose();
    _managerNameController.dispose();
    _managerEmailController.dispose();
    _emailAssociationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState?.validate() ?? false) {
      _authViewmodel.signUpState.value = UiStateLoading();
      final association = AssociationModel(
        id: '',
        name: _nameController.text.trim(),
        managerName: _managerNameController.text.trim(),
        managerEmail: _managerEmailController.text.trim(),
        emailAssociation: _emailAssociationController.text.trim(),
        verified: false,
        description: _descriptionController.text.trim(),
      );

      try {
        _authViewmodel.signUpAssociation(
          association: association,
          password: _passwordController.text.trim(),
        );
        Future.delayed(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Inscription réussie !'),
                duration: Duration(seconds: 2),
              ),
            );
            Get.offAllNamed('/onboarding');
        });
      } catch (e) {
        _authViewmodel.signUpState.value = UiStateError(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'inscription : ${e.toString()}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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
                        child: CustomLabel(
                          label: 'Créer un compte association',
                          color: Colors.white,
                          fontSize: 25,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // Association Name
                                        Row(
                                          children: [
                                            CustomLabel(
                                              label: 'Nom de l\'association',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key(
                                            'associationNameField',
                                          ),
                                          hint:
                                              'Entrez le nom de l\'association',
                                          controller: _nameController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          keyBoardType: 'text',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Veuillez entrer le nom de l\'association';
                                            }
                                            if (value.length < 3) {
                                              return 'Le nom doit contenir au moins 3 caractères';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        // Description
                                        Row(
                                          children: [
                                            CustomLabel(
                                              label: 'Description de l\'association',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('descriptionField'),
                                          hint:
                                              'Entrez une description de l\'association',
                                          controller: _descriptionController,
                                          contentRequired: true,
                                          maxLines: 5,
                                          keyBoardType: 'text',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Veuillez entrer une description';
                                            }
                                            if (value.length < 10) {
                                              return 'La description doit contenir au moins 10 caractères';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        // Manager Name
                                        Row(
                                          children: [
                                            CustomLabel(
                                              label: 'Nom du responsable',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('managerNameField'),
                                          hint: 'Entrez le nom du responsable',
                                          controller: _managerNameController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          keyBoardType: 'text',
                                        ),
                                        const SizedBox(height: 16),
                                        // Manager Email
                                        Row(
                                          children: [
                                            CustomLabel(
                                              label: 'Email du responsable',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('managerEmailField'),
                                          hint:
                                              'Entrez l\'email du responsable',
                                          controller: _managerEmailController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                        // Association Email
                                        Row(
                                          children: [
                                            CustomLabel(
                                              label: 'Email de l\'association',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key(
                                            'associationEmailField',
                                          ),
                                          hint:
                                              'Entrez l\'email de l\'association',
                                          controller:
                                              _emailAssociationController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez entrer l\'email de l\'association';
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
                                            CustomLabel(
                                              label: 'Mot de passe',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key('passwordField'),
                                          hint: 'Entrez un mot de passe',
                                          controller: _passwordController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          obscureText: true,
                                          keyBoardType: 'text',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            CustomLabel(
                                              label: 'Confirmer le mot de passe',
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        CustomTextformfield(
                                          key: const Key(
                                            'confirmPasswordField',
                                          ),
                                          hint: 'Confirmez le mot de passe',
                                          controller:
                                              _confirmPasswordController,
                                          contentRequired: true,
                                          maxLines: 1,
                                          obscureText: true,
                                          keyBoardType: 'text',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Veuillez confirmer le mot de passe';
                                            }
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Les mots de passe ne correspondent pas';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        // identification File
                                        /*                                         Row(
                                          children: [
                                            CustomLabel('Fichier d\'identification', Colors.white, 16),
                                            const SizedBox(width: 5),
                                            const Text('*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                )),
                                          ],
                                        ),
      */
                                        /*                                         const SizedBox(height: 6),
                                        ReceiptPicker(),
                                        const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Text(
                                                          'Numéros de Mobile Money',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                              const SizedBox(width: 5),
                                                GestureDetector(
                                                onTap: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Au moins un numéro est requis'),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                )
                                            ],
                                          ),
                                        const SizedBox(height: 8), */
                                        // Mobile Money Numbers
                                        /*                                             Row(
                                              children: [
                                                  Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo-om.jpeg',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                  ),
                                                Expanded(
                                                  child: CustomTextformfield(
                                                    key: const Key('orangeMoneyNumberField'),
                                                    hint: 'Entrez un numéro Orange Money',
                                                    controller: _orangeMoneyNumberController,
                                                    contentRequired: false,
                                                    maxLines: 1,
                                                    keyBoardType: 'phone',
                                                  ),
                                                ),

                                              ],
                                            ), */
                                        /*                                         const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo-moov-money.png',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextformfield(
                                                    key: const Key('moovMoneyNumberField'),
                                                    hint: 'Entrez un numéro Moov Money',
                                                    controller: _moovMoneyNumberController,
                                                    contentRequired: false,
                                                    maxLines: 1,
                                                    keyBoardType: 'phone',
                                                  ),
                                                ),
                                              ],
                                            ),
                                        const SizedBox(height: 8), */
                                        /*                                             Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo-mtn-money.png',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextformfield(
                                                    key: const Key('mtnMoneyNumberField'),
                                                    hint: 'Entrez un numéro MTN Money',
                                                    controller: _mtnMoneyNumberController,
                                                    contentRequired: false,
                                                    maxLines: 1,
                                                    keyBoardType: 'phone',
                                                  ),
                                                ),
                                              ],
                                            ),
                                        const SizedBox(height: 8), */
                                        /*                                             Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo-wave.jpeg',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextformfield(
                                                    key: const Key('waveMoneyNumberField'),
                                                    hint: 'Entrez un numéro Wave Money',
                                                    controller: _waveMoneyNumberController,
                                                    contentRequired: false,
                                                    maxLines: 1,
                                                    keyBoardType: 'phone',
                                                  ),
                                                ),
                                              ],
                                            ), */

                                        /*                                         const SizedBox(height: 16),
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
                                                      'Liens des réseaux sociaux (Optionnel)',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
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
                                        const SizedBox(height: 8), */
                                        // Social Media Links
                                        /*                                             Row(
                                              children: [
                                                  Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo_facebook.png',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                  ),
                                                  Expanded(
                                                  child: CustomTextformfield(
                                                  key: const Key('facebookLinkField'),
                                                  hint: 'Exemple: https://www.facebook.com/association',
                                                  controller: _facebookLink,
                                                  contentRequired: false,
                                                  maxLines: 1,
                                                  keyBoardType: 'text',
                                                ),
                                                  ),
                                              ],
                                            ), */
                                        /*                                         const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo_insta.png',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextformfield(
                                                    key: const Key('instagramLinkField'),
                                                    hint: 'Exemple: https://www.instagram.com/association',
                                                    controller: _instagramLink,
                                                    contentRequired: false,
                                                    maxLines: 1,
                                                    keyBoardType: 'text',
                                                  ),
                                                ),
                                              ],
                                            ),
                                        const SizedBox(height: 8), */
                                        /*                                             Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Image.asset(
                                                    'assets/logos/logo_x.png',
                                                    width: 28,
                                                    height: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextformfield(
                                                    key: const Key('twitterLinkField'),
                                                    hint: 'Exemple: https://www.x.com/association',
                                                    controller: _twitterLink,
                                                    contentRequired: false,
                                                    maxLines: 1,
                                                    keyBoardType: 'text',
                                                  ),
                                                ),
                                              ],
                                            ), */
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                          key: const Key('signUpButton'),
                                          onPressed: () {
                                            _signup();
                                          },
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
                                              final state = _authViewmodel.signUpState.value;

                                             if (state == null) {
                                                return const Text(
                                                  'Créer un compte',
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
                                                  'Créer un compte',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              }
                                            }),
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
