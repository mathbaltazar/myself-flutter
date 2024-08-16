import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myselff_flutter/app/core/components/lists/typed_list_view.dart';
import 'package:myselff_flutter/app/core/components/mixins/dialog_mixin.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/entity/payment_type_entity.dart';
import 'package:myselff_flutter/app/modules/expenses/presentation/controllers/payment_type_select_dialog_controller.dart';
import 'package:signals/signals_flutter.dart';

class PaymentSelectDialog extends StatefulWidget
    with StatefulWidgetDialogMixin {
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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (mounted) {
      controller.getPaymentTypes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Center(child: FaIcon(FontAwesomeIcons.solidCreditCard)),
      title: const Text('Tipos de pagamento'),
      content: SingleChildScrollView(
        child: Scrollbar(
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints.loose(const Size.fromHeight(224)),
            child: TypedListView(
              items: controller.paymentTypeList.watch(context),
              itemBuilder: (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const FaIcon(FontAwesomeIcons.caretRight),
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
