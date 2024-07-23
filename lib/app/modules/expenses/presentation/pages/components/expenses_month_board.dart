part of '../expenses_list_page.dart';

class _ExpensesMonthBoard extends StatefulWidget {
  const _ExpensesMonthBoard(this.controller);

  final ExpensesListController controller;

  @override
  State<_ExpensesMonthBoard> createState() => _ExpensesMonthBoardState();
}

class _ExpensesMonthBoardState extends State<_ExpensesMonthBoard>
    with SingleTickerProviderStateMixin<_ExpensesMonthBoard> {
  AnimationController? animController;
  double startAnim = 0;

  @override
  void initState() {
    animController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              startAnim = -1;
              animController?.forward(from: 0);
              widget.controller.onMonthBackButtonClick();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Observer(builder: (context) =>
                          CircularProgressCheckIndicator(progressValue: _progressValue()),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total do mês'),
                          Observer(builder: (_) => Text(
                                '\$ ${widget.controller.totalExpensesAmount.formatCurrency()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              )
                          ),
                          const SizedBox(height: 10),
                          const Text('Total pago'),
                          Observer(builder: (_) => Text(
                                '\$ ${widget.controller.totalPaidExpensesAmount.formatCurrency()}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyselffTheme.colorPrimary),
                              )
                          ),
                          const SizedBox(height: 10),
                          const Text('Ainda falta'),
                          Observer(builder: (context) => Text(
                                '\$ ${widget.controller.totalUnpaid.formatCurrency()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: widget.controller.totalUnpaid == 0
                                        ? MyselffTheme.colorPrimary.withAlpha(120)
                                        : MyselffTheme.colorError.withAlpha(120)),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Observer(builder: (_) => Text(
                              widget.controller.currentDate
                                  .formatYearMonthExtended(),
                              style: const TextStyle(fontSize: 16))
                          .animate(controller: animController)
                          .slideX(begin: startAnim, curve: Curves.easeOutCubic),
                    ),
                  ],
              )
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: () {
              startAnim = 1;
              animController?.forward(from: 0);
              widget.controller.onMonthForwardButtonClick();
            },
          ),
        ],
      ),
    );
  }

  double _progressValue() => widget.controller.totalExpensesAmount == 0
      ? 1.0
      : widget.controller.totalPaidExpensesAmount / widget.controller.totalExpensesAmount;

  @override
  void dispose() {
    animController?.dispose();
    super.dispose();
  }
}
