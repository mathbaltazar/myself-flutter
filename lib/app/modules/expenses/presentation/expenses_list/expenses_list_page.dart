import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/routes/app_routes.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/modules/expenses/domain/model/expense_model.dart';

import 'components/expense_item_details.dart';
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
          title: const Text('Despesas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                            onExpenseClick: () => {
                              _showExpenseDetails(
                                  context, controller.expenses[index])
                            },
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
                  await Modular.to.pushNamed(AppRoutes.saveExpense);
              if (persisted == true) {
                controller.loadExpenses(controller.resumeModel.currentDate);
              }
            }),
      ),
    );
  }

  void _showExpenseDetails(BuildContext context, ExpenseModel expense) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ExpenseItemDetails(
        expense: expense,
        onEdit: () {
          controller.editExpense(expense.id!);
        },
        onDelete: () async {
          final deleted = await _showDeleteConfirmation(context, expense.id!);
          if (deleted == true) {
            Modular.to.pop();
          }
        },
        onMarkAsPaid: () {
          controller.togglePaid(expense);
          Modular.to.pop();
        },
      ),
    );
  }

  Future<dynamic> _showDeleteConfirmation(
      BuildContext context, int expenseId) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(
          Icons.delete_forever_rounded,
          size: 48,
        ),
        content: const Text(
          'Excluir a despesa ?',
          textAlign: TextAlign.center,
        ),
        insetPadding: const EdgeInsets.all(16),
        actions: [
          TextButton(
            onPressed: () {
              Modular.to.pop();
            },
            child: const Text('Cancelar'),
          ),
          OutlinedButton(
            onPressed: () {
              controller.deleteExpense(expenseId);
              Modular.to.pop(true);
            },
            child: Text(
              'Excluir',
              style: TextStyle(
                color: MyselffTheme.errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
