import 'package:flutter/material.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myself_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myself_flutter/app/core/utils/formatters/date_formatter.dart';

import '../../../domain/model/expense_model.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(
    this.expense, {
    required this.onExpenseClick,
    super.key,
  });

  final void Function() onExpenseClick;
  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onExpenseClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.paid,
                color: expense.paid
                    ? MyselfTheme.colorPrimary
                    : MyselfTheme.errorColor,
                semanticLabel: expense.paid ? 'Pago! :)' : 'Não pago =(',
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.description,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      expense.paymentDate.format(),
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                '\$ ${expense.amount.formatCurrency()}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
