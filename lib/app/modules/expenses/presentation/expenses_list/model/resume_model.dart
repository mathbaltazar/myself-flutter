class ResumeModel {
  ResumeModel({
    required this.currentDate,
    required this.totalExpenses,
    required this.totalPaid,
  });

  factory ResumeModel.instance() => ResumeModel(
        currentDate: DateTime.now().copyWith(day: 1),
        totalPaid: 0.0,
        totalExpenses: 0.0,
      );

  DateTime currentDate;
  double totalExpenses;
  double totalPaid;
}
