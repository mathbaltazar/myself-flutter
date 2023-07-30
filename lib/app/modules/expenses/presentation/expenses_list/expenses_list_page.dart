import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myself_flutter/app/core/constants/app_routes.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';

import 'components/expense_list_item.dart';
import 'components/expenses_resume_board.dart';
import 'expenses_list_controller.dart';
import 'expenses_list_states.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key, required this.controller});

  final ExpensesListController controller;

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
    widget.controller.init();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  _listener() {
    final state = widget.controller.value;

    if (state is ExpensesListStart) {
      widget.controller.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas'),
        ),
        body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, state, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ExpensesResumeBoard(
                    currentDate: controller.date,
                    totalExpenses: controller.totalExpenses,
                    totalPaid: controller.totalPaid,
                    onPreviousMonth: controller.previousMonth,
                    onNextMonth: controller.nextMonth,
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Registros',
                        style: TextStyle(
                            fontSize: 16, color: MyselfTheme.colorPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: controller.expenses.isEmpty
                        ? const Text("Nada por aqui =)")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.expenses.length,
                            itemBuilder: (context, index) =>
                                ExpenseListItem(controller.expenses[index]),
                          ),
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Modular.to.pushNamed(AppRoutes.saveExpense);
            }),
      ),
    );
  }
}
