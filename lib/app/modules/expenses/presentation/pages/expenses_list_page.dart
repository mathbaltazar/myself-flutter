import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/core/components/buttons/link_button.dart';
import 'package:myselff_flutter/app/core/components/containers/conditional.dart';
import 'package:myselff_flutter/app/core/components/containers/statefui_component.dart';
import 'package:myselff_flutter/app/core/components/dialogs/confirmation_alert_dialog.dart';
import 'package:myselff_flutter/app/core/components/indicators/circular_progress_check_indicator.dart';
import 'package:myselff_flutter/app/core/components/mixins/bottom_sheet_mixin.dart';
import 'package:myselff_flutter/app/core/extensions/object_extensions.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';

import 'components/expense_list_item.dart';
import 'components/payment_select_dialog.dart';
import '../controllers/expenses_list_controller.dart';

part 'components/expense_details_bottom_sheet.dart';
part 'components/expenses_month_board.dart';


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
    // fetch the expenses from repository
    widget.controller.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _userInfoTitleWidget(),
        actions: [
          Visibility(
              visible: FirebaseAuth.instance.currentUser != null,
              child: IconButton(
                  onPressed: widget.controller.signOut,
                  icon: const Icon(Icons.logout)))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.controller.onExpenseAddButtonClicked,
        child: const Icon(Icons.add),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Despesas'),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: _ExpensesMonthBoard(widget.controller),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Despesas',
              style: TextStyle(
                fontSize: 16,
                color: MyselffTheme.colorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Observer(
                builder: (_) => Conditional(widget.controller.expenses.isEmpty,
                          onCondition: const Text("Nenhuma despesa cadastrada."),
                          onElse: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.controller.expenses.length,
                            itemBuilder: (ctx, index) {
                              final expenseItem = widget.controller.expenses[index];
                              return ExpenseListItem(expenseItem,
                              onItemClick: () {
                                widget.controller.setSelectedExpense(expenseItem);
                                _ExpenseDetailsBottomSheet(controller: widget.controller)
                                    .show(ctx);
                          },
                      );
                            },
                          ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _userInfoTitleWidget() {
    final user = FirebaseAuth.instance.currentUser;
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: user?.let((it) => NetworkImage(it.photoURL!)),
        ),
        const SizedBox(width: 16),
        Text(user?.displayName ?? 'myselff'),
      ],
    );
  }
}
