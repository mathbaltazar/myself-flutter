import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/components/lists/typed_list_view.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/payment_type_select_dialog_controller.dart';
import 'package:signals/signals_flutter.dart';

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
            child: TypedListView(
                  items: controller.paymentTypeList.watch(context),
                  itemBuilder: (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.arrow_right),
                    title: Text(item.name),
                    onTap: () => widget.onSelect(item),
                  ),
                  separatorBuilder: () => const Divider(),
                ),
          ),
        ),
      ),
    );
  }
}
