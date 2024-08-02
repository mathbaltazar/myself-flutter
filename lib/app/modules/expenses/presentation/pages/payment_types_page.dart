import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/components/containers/conditional.dart';
import 'package:myselff_flutter/app/core/components/dialogs/confirmation_alert_dialog.dart';
import 'package:myselff_flutter/app/core/components/lists/typed_list_view.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_detail_entity.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/payment_types_controller.dart';
import 'package:signals/signals_flutter.dart';

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
            Watch.builder(
              builder: (_) => Conditional(widget.controller.showPaymentTypeInput.get(),
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
              child: Watch.builder(
                builder: (_) => Conditional(widget.controller.paymentTypesList.isEmpty,
                  onCondition: const Center(child: Text('Não há tipos de pagamento para listar.')),
                  onElse: TypedListView(
                    items: widget.controller.paymentTypesList,
                    itemBuilder: (item) => _PaymentTypeDetailListItem(widget.controller, item),
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
