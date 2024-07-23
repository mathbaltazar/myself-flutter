import 'package:flutter/material.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';

import '../../../domain/entity/expense_entity.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem(
    this.expense, {
    required this.onItemClick,
    super.key,
  });

  final Function() onItemClick;
  final ExpenseEntity expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onItemClick,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.paid,
                color: expense.paid
                    ? MyselffTheme.colorPrimary
                    : MyselffTheme.colorError,
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
                    ),
                    Text(
                      expense.paymentDate.format(),
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      expense.paymentType?.name ?? 'Não definido.',
                      style: TextStyle(
                          fontSize: 10,
                          color: expense.paymentType == null
                              ? Colors.black26
                              : null),
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
