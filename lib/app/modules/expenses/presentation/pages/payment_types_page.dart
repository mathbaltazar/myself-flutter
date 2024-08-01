import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/components/containers/conditional.dart';
import 'package:myselff_flutter/app/core/components/dialogs/confirmation_alert_dialog.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

import '../../domain/entity/payment_type_detail_entity.dart';
import '../../domain/entity/payment_type_entity.dart';
import '../controllers/payment_types_controller.dart';

part 'components/payment_type_detail_list_item.dart';
part 'components/payment_type_input.dart';

class PaymentTypesPage extends StatefulWidget {
  const PaymentTypesPage({super.key, required this.controller});

  final PaymentTypesController controller;

  @override
  State<PaymentTypesPage> createState() => _PaymentTypesPageState();
}

class _PaymentTypesPageState extends State<PaymentTypesPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.getPaymentTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0, /* If "0", removes shadowing after any body scroll physics */
        title: const Text('Gerenciar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Observer(
              builder: (_) => Conditional(widget.controller.showPaymentTypeInput,
                onCondition: _PaymentTypeInput(widget.controller),
                onElse: Row(
                  children: [
                    const Icon(Icons.credit_card),
                    const SizedBox(width: 8),
                    const Text('Tipos de pagamento'),
                    const Spacer(),
                    TextButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: widget.controller.onAddNewPaymentTypeClick,
                        label: const Text('Adicionar')),
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Observer(
                builder: (_) => Conditional(widget.controller.paymentTypesList.isEmpty,
                  onCondition: const Center(child: Text('Não há tipos de pagamento para listar.')),
                  onElse: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.controller.paymentTypesList.length,
                    itemBuilder: (_, index) => _PaymentTypeDetailListItem(
                      widget.controller,
                      widget.controller.paymentTypesList[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
