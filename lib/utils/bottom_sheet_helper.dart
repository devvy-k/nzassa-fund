import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomSheetHelper {
  static void showCustomBottomSheet({required BuildContext context}) {
    final TextEditingController amountController = TextEditingController();

    selectedPaymentMethod = null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
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
                              selectedPaymentMethod == null
                                  ? _buildPaymentSelection(setState)
                                  : _buildAmountInput(
                                    context,
                                    setState,
                                    selectedPaymentMethod!,
                                    amountController,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  static Widget _buildPaymentSelection(Function(void Function()) setState) {
    return Column(
      key: const ValueKey('paymentSelection'),
      children: [
        Card(
          child: ListTile(
            leading: Image.asset('assets/logos/logo-om.jpeg'),
            title: const Text('Orange Money'),
            onTap:
                () => setState(() {
                  selectedPaymentMethod = 'Orange Money';
                }),
          ),
        ),
        const SizedBox(height: 3.0),
        Card(
          child: ListTile(
            leading: Image.asset('assets/logos/logo-wave.jpeg'),
            title: const Text('Wave'),
            onTap:
                () => setState(() {
                  selectedPaymentMethod = 'Wave';
                }),
          ),
        ),
        const SizedBox(height: 3.0),
        Card(
          child: ListTile(
            leading: Image.asset('assets/logos/logo-mtn-money.png'),
            title: const Text('MTN Mobile Money'),
            onTap:
                () => setState(() {
                  selectedPaymentMethod = 'MTN Mobile Money';
                }),
          ),
        ),
        const SizedBox(height: 3.0),
        Card(
          child: ListTile(
            leading: Image.asset('assets/logos/logo-moov-money.png'),
            title: const Text('Moov Money'),
            onTap:
                () => setState(() {
                  selectedPaymentMethod = 'Moov Money';
                }),
          ),
        ),
      ],
    );
  }

  static Widget _buildAmountInput(
    BuildContext context,
    Function(void Function()) setState,
    String? selectedPaymentMethod,
    TextEditingController amountController,
  ) {
    return Column(
      key: const ValueKey('amountInput'),
      children: [
        Text(
          'Entrer le montant pour $selectedPaymentMethod',
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: amountController,
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
          onPressed: () {
            String amount = amountController.text;
            if (amount.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Veuillez entrer un montant')),
              );
              return;
            }
            print('Méthode: $selectedPaymentMethod, Montant: $amount');
            Navigator.pop(context);
          },
          child: const Text('Confirmer le paiement'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              BottomSheetHelper.selectedPaymentMethod = null;
              amountController.clear();
            });
          },
          child: const Text('← Retour à la sélection'),
        ),
      ],
    );
  }

  // Stocké ici pour permettre au helper d’y accéder
  static String? selectedPaymentMethod;
}
