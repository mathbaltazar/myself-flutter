import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myselff_flutter/app/core/theme/color_schemes.g.dart';
import 'package:myselff_flutter/app/core/utils/formatters/currency_formatter.dart';
import 'package:myselff_flutter/app/core/utils/formatters/date_formatter.dart';
import '../model/resume_model.dart';

class ExpensesResumeBoard extends StatefulWidget {
  const ExpensesResumeBoard({
    super.key,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.resume,
  });

  final void Function() onPreviousMonth;
  final void Function() onNextMonth;
  final ResumeModel resume;

  @override
  State<ExpensesResumeBoard> createState() => _ExpensesResumeBoardState();
}

class _ExpensesResumeBoardState extends State<ExpensesResumeBoard>
    with TickerProviderStateMixin<ExpensesResumeBoard> {
  AnimationController? animController;
  double startAnim = 0;

  @override
  void initState() {
    animController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(
            color: MyselffTheme.outlineColor,
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              startAnim = -1;
              animController?.forward(from: 0);
              widget.onPreviousMonth();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: _progressScale()),
                            duration: const Duration(seconds: 1),
                            builder: (ctx, value, _) =>
                                CircularProgressIndicator(
                              value: value,
                              strokeCap: StrokeCap.round,
                              strokeAlign: 12,
                              backgroundColor: Colors.black26,
                            ),
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 36,
                            color: _progressScale() == 1
                                ? MyselffTheme.colorPrimary
                                : Colors.black54,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total do mês'),
                          Text(
                            'R\$ ${widget.resume.totalExpenses.formatCurrency()}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 10),
                          const Text('Total pago'),
                          Text(
                            'R\$ ${widget.resume.totalPaid.formatCurrency()}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: _progressScale() == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _progressScale() == 1
                                    ? MyselffTheme.colorPrimary
                                    : Colors.black54),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ainda falta',
                            style: TextStyle(color: _progressScale() == 1
                                ? MyselffTheme.colorPrimary.withAlpha(100)
                                : MyselffTheme.errorColor.withAlpha(100)),
                          ),
                          Text(
                            'R\$ ${widget.resume.totalUnpaid.formatCurrency()}',
                            style: TextStyle(
                                fontWeight: _progressScale() == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _progressScale() == 1
                                    ? MyselffTheme.colorPrimary.withAlpha(120)
                                    : MyselffTheme.errorColor.withAlpha(120)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(widget.resume.currentDate.formatYearMonth(),
                      style: const TextStyle(fontSize: 16)),
                ],
              )
                  .animate(controller: animController)
                  .slideX(begin: startAnim, end: 0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: () {
              startAnim = 1;
              animController?.forward(from: 0);
              widget.onNextMonth();
            },
          ),
        ],
      ),
    );
  }

  _progressScale() {
    return widget.resume.totalExpenses == 0
        ? 1.0
        : widget.resume.totalPaid / widget.resume.totalExpenses;
  }
}
