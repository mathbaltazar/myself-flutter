import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/presentation/widgets/confirmation_alert_dialog.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/structure/inline_functions.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';

import '../../domain/model/expense_model.dart';
import '../widgets/payment_select_dialog.dart';
import 'components/expense_details_widget.dart';
import 'components/expense_list_item.dart';
import 'components/expenses_resume_board.dart';
import 'expenses_list_controller.dart';

class ExpensesListPage extends StatelessWidget {
  const ExpensesListPage({super.key, required this.controller});

  final ExpensesListController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _userInfoTitleWidget(),
          actions: [
            Visibility(
                visible: FirebaseAuth.instance.currentUser != null,
                child: IconButton(
                    onPressed: controller.signOut,
                    icon: const Icon(Icons.logout)))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Despesas'),
              const SizedBox(height: 10),
              Observer(
                builder: (_) => ExpensesResumeBoard(
                  resume: controller.resumeModel,
                  onPreviousMonth: controller.previousMonth,
                  onNextMonth: controller.nextMonth,
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Registros',
                    style: TextStyle(
                        fontSize: 16, color: MyselffTheme.colorPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Observer(
                builder: (_) => Expanded(
                  child: controller.expenses.isEmpty
                      ? const Text("Nada por aqui =)")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.expenses.length,
                          itemBuilder: (_, index) => ExpenseListItem(
                            controller.expenses[index],
                            onItemClick: () => _showExpenseDetails(
                                  context, controller.expenses[index]),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final persisted =
                  await Modular.to.pushNamed(AppRoutes.expenseRoute + AppRoutes.saveExpense);
              if (persisted == true) {
                controller.loadExpenses(controller.resumeModel.currentDate);
              }
            }),
      ),
    );
  }

  void _showExpenseDetails(BuildContext context, ExpenseModel expense) async {
    var method =
        await controller.findPaymentMethodById(expense.paymentMethodId);
    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        builder: (_) => ExpenseDetailsWidget(
          controller: controller,
          expense: expense,
          paymentMethod: method,
          onEdit: () => controller.editExpense(expense.id!),
          onDelete: () async {
            final deleted = await _showDeleteConfirmation(context, expense.id!);
            if (deleted == true) {
              Modular.to.pop();
            }
          },
          onMarkAsPaid: () {
            controller.togglePaid(expense);
            Modular.to.pop();
            _showExpenseDetails(context, expense);
          },
          onSelectPaymentMethod: () async {
            final selectedMethod = await _showSelectPaymentDialog(context);
            if (selectedMethod != null) {
              controller.definePaymentFor(selectedMethod, expense);
              Modular.to.pop();
              _showExpenseDetails(context, expense);
            }
          },
        ),
      );
    }
  }

  Future<dynamic> _showDeleteConfirmation(BuildContext context, int expenseId) {
    return showAdaptiveDialog(
      context: context,
      builder: (_) => ConfirmationAlertDialog(
          icon: const Icon(Icons.delete_rounded),
          title: 'Excluir a despesa ?',
          confirmLabel: 'Excluir',
          confirmLabelTextStyle: TextStyle(color: MyselffTheme.errorColor),
          onCancel: Modular.to.pop,
          onConfirm: () {
            controller.deleteExpense(expenseId);
            Modular.to.pop(true);
          }),
    );
  }

  Widget _userInfoTitleWidget() {
    final user = FirebaseAuth.instance.currentUser;
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: user?.let((it) => NetworkImage(it.photoURL!)) ,
        ),
        const SizedBox(width: 16),
        Text(user?.displayName ?? 'myselff'),
      ],
    );
  }

  Future<dynamic> _showSelectPaymentDialog(BuildContext context) {
    return controller.findAllPaymentMethods()
        .then((methods) => showAdaptiveDialog(
          context: context,
          builder: (_) => PaymentSelectDialog(
              paymentMethods: methods,
              onSelect: (selected) => Modular.to.pop(selected)),
        ));
  }
}
