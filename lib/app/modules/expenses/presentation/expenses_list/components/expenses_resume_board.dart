import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myself_flutter/app/core/theme/color_schemes.g.dart';

class ExpensesResumeBoard extends StatelessWidget {
  const ExpensesResumeBoard({
    super.key,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.currentDate,
    required this.totalExpenses,
    required this.totalPaid,
  });

  final void Function() onPreviousMonth;
  final void Function() onNextMonth;
  final DateTime currentDate;
  final double totalExpenses;
  final double totalPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyselfTheme.outlineColor)),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onPreviousMonth,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(DateFormat.yMMMM().format(currentDate)),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total pago'),
                      Text('Total do mês'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _progressScale(),
                    valueColor:
                        AlwaysStoppedAnimation(MyselfTheme.colorPrimary),
                    backgroundColor: Colors.black26,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('R\$ ${totalPaid.toStringAsFixed(2)}'),
                      Text('R\$ ${totalExpenses.toStringAsFixed(2)}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: onNextMonth,
          ),
        ],
      ),
    );
  }

  _progressScale() {
    return totalExpenses == 0 ? 1.0 : totalPaid / totalExpenses;
  }
}
