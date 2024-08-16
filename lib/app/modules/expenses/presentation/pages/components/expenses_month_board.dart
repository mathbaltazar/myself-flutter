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
            icon: const FaIcon(FontAwesomeIcons.angleLeft),
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
                      Watch.builder(builder: (_) =>
                          CircularProgressCheckIndicator(progressValue: _progressValue()),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total do mês'),
                          Watch.builder(builder: (_) => Text(
                                '\$ ${widget.controller.totalExpensesAmount.get().formatCurrency()}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              )
                          ),
                          const SizedBox(height: 10),
                          const Text('Total pago'),
                          Watch.builder(builder: (_) => Text(
                                '\$ ${widget.controller.totalPaidExpensesAmount.get().formatCurrency()}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary),
                              )
                          ),
                          const SizedBox(height: 10),
                          const Text('Ainda falta'),
                          Watch.builder(builder: (_) => Text(
                                '\$ ${widget.controller.totalUnpaid.get().formatCurrency()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: widget.controller.totalUnpaid.get() == 0
                                        ? Theme.of(context).colorScheme.primary.withAlpha(120)
                                        : Theme.of(context).colorScheme.error.withAlpha(120)),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Watch.builder(builder: (_) => Text(
                              widget.controller.currentDate.get().formatYearMonthExtended(),
                              style: const TextStyle(fontSize: 16))
                          .animate(controller: animController)
                          .slideX(begin: startAnim, curve: Curves.easeOutCubic),
                    ),
                  ],
              )
            ),
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.angleRight),
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

  double _progressValue() => widget.controller.totalExpensesAmount.get() == 0
      ? 1.0
      : widget.controller.totalPaidExpensesAmount.get() / widget.controller.totalExpensesAmount.get();

  @override
  void dispose() {
    animController?.dispose();
    super.dispose();
  }
}
