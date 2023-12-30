import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'payment_methods_controller.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key, required this.controller});

  final PaymentMethodsController controller;

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Métodos de pagamento'),
        ),
        body: Column(
          children: [
            const Text('Descrição dos métodos de pagamento'),
            const SizedBox(height: 15),
            Observer(
              builder: (_) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.paymentMethodsList.length,
                  itemBuilder: (_, index) {
                    final paymentMethod =
                        widget.controller.paymentMethodsList[index];
                    return ListTile(title: Text(paymentMethod.name));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
