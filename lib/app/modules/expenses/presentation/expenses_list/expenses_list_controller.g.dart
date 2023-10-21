// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpensesListController on _ExpensesListController, Store {
  late final _$resumeModelAtom =
      Atom(name: '_ExpensesListController.resumeModel', context: context);

  @override
  ResumeModel get resumeModel {
    _$resumeModelAtom.reportRead();
    return super.resumeModel;
  }

  @override
  set resumeModel(ResumeModel value) {
    _$resumeModelAtom.reportWrite(value, super.resumeModel, () {
      super.resumeModel = value;
    });
  }

  late final _$expensesAtom =
      Atom(name: '_ExpensesListController.expenses', context: context);

  @override
  ObservableList<ExpenseModel> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(ObservableList<ExpenseModel> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$_ExpensesListControllerActionController =
      ActionController(name: '_ExpensesListController', context: context);

  @override
  dynamic setResumeModel(dynamic value) {
    final _$actionInfo = _$_ExpensesListControllerActionController.startAction(
        name: '_ExpensesListController.setResumeModel');
    try {
      return super.setResumeModel(value);
    } finally {
      _$_ExpensesListControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
resumeModel: ${resumeModel},
expenses: ${expenses}
    ''';
  }
}
