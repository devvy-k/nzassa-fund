import 'dart:developer' as console;

import 'package:cinetpay/cinetpay.dart';
import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:crowfunding_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const PaymentBottomSheet(),
    );
  }

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  final ProjectsViewmodel projectsViewmodel = Get.find<ProjectsViewmodel>();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedPaymentMethod;
  Map<String, dynamic>? response;
  IconData? icon;
  Color? color;
  String? message;
  bool show = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child:
                    _selectedPaymentMethod == null
                        ? _buildPaymentSelection()
                        : _buildAmountInput(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentSelection() {
    return Column(
      key: const ValueKey('paymentSelection'),
      children: [
        _paymentOption('Orange Money', 'assets/logos/logo-om.jpeg'),
        _paymentOption('Wave', 'assets/logos/logo-wave.jpeg'),
        _paymentOption('MTN Mobile Money', 'assets/logos/logo-mtn-money.png'),
        _paymentOption('Moov Money', 'assets/logos/logo-moov-money.png'),
      ],
    );
  }

  Widget _paymentOption(String method, String imagePath) {
    return Card(
      child: ListTile(
        leading: Image.asset(imagePath, width: 40),
        title: Text(method),
        onTap: () => setState(() => _selectedPaymentMethod = method),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      key: const ValueKey('amountInput'),
      children: [
        Text(
          'Entrer le montant pour $_selectedPaymentMethod',
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: 'Montant',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _onConfirmPayment,
          child: const Text('Confirmer le paiement'),
        ),
        TextButton(
          onPressed:
              () => setState(() {
                _selectedPaymentMethod = null;
                _amountController.clear();
              }),
          child: const Text('← Retour à la sélection'),
        ),
      ],
    );
  }

  void _onConfirmPayment() async {
    final amount = _amountController.text;
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un montant')),
      );
      return;
    }

    double _amount;
    try {
      _amount = double.parse(amount);

      if (_amount < 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Le montant doit être supérieur ou égal à 100'),
          ),
        );
        return;
      }
      if (_amount > 1500000) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Le montant ne doit pas dépasser 1 500 000'),
          ),
        );
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Montant invalide')));
      return;
    }

    final String transactionId = Utils.generateId();

    await Get.to(
      CinetPayCheckout(
        title: 'Paiement',
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        titleBackgroundColor: Colors.green,
        configData: <String, dynamic>{
          'apikey': dotenv.env['CINETPAY_API_KEY'],
          'site_id': dotenv.env['CINETPAY_SITE_ID'],
          'notify_url': 'https://nzassa-fund-back.onrender.com/cinetpay/notify',
        },
        paymentData: <String, dynamic>{
          'transaction_id': transactionId,
          'amount': _amount,
          'currency': 'XOF',
          'channels': 'ALL',
          'description': 'Paiement pour $_selectedPaymentMethod',
        },
        waitResponse: (data) {
          if (mounted) {
            setState(() {
              response = data;
              icon =
                  data['status'] == 'ACCEPTED'
                      ? Icons.check_circle
                      : Icons.mood_bad_rounded;
              color =
                  data['status'] == 'ACCEPTED'
                      ? Colors.green
                      : Colors.redAccent;
              show = true;
              Get.back();
            });
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() {
              response = error;
              message = response!['description'];
              console.log('Erreur: $error');
              icon = Icons.warning_rounded;
              color = Colors.yellowAccent;
              show = true;
              Get.back();
            });
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erreur: $error')));
        },
      ),
    );

    print('Méthode: $_selectedPaymentMethod, Montant: $amount');
    Navigator.pop(context);
    projectsViewmodel.simulatePayment(true);
  }
}
