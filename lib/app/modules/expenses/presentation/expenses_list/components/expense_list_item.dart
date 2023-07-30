import 'package:flutter/material.dart';
import 'package:myself_flutter/app/core/commons/formatters/date_formatter.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';

import '../../../domain/model/expense_model.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(
    this.expense, {
    super.key,
  });

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    expense.description!,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    expense.paymentDate?.format() ?? '',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Text(
              '\$ ${expense.value.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
