import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entity/payment_type_entity.dart';
import '../../controllers/payment_type_select_dialog_controller.dart';

class PaymentSelectDialog extends StatefulWidget {
  const PaymentSelectDialog({
    super.key,
    required this.onSelect,
  });

  final Function(PaymentTypeEntity?) onSelect;

  @override
  State<PaymentSelectDialog> createState() => _PaymentSelectDialogState();
}

class _PaymentSelectDialogState extends State<PaymentSelectDialog> {
  final controller = Modular.get<PaymentTypeSelectDialogController>();

  @override
  void initState() {
    super.initState();
    controller.getPaymentTypes();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Icon(Icons.credit_card),
      title: const Text('Métodos de pagamento',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Scrollbar(
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints.loose(const Size.fromHeight(224)),
            child: Observer(builder: (context) {
              return ListView.separated(
                itemCount: controller.paymentTypeList.length,
                itemBuilder: (_, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.arrow_right),
                  title: Text(controller.paymentTypeList[index].name),
                  onTap: () => widget.onSelect(controller.paymentTypeList[index]),
                ),
                separatorBuilder: (_, __) => const Divider(),
              );
            }),
          ),
        ),
      ),
    );
  }
}
