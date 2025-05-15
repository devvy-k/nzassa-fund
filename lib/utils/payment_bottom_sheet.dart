import 'package:crowfunding_project/ui/features/projects/project_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void _onConfirmPayment() {
    final amount = _amountController.text;
    if (amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un montant')),
      );
      return;
    }

    print('Méthode: $_selectedPaymentMethod, Montant: $amount');
    Navigator.pop(context);
    projectsViewmodel.simulatePayment(true);
  }
}
