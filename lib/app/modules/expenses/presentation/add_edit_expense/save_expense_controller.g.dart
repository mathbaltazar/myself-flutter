// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_expense_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SaveExpenseController on _SaveExpenseController, Store {
  late final _$errorMessageAtom =
      Atom(name: '_SaveExpenseController.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$editingAtom =
      Atom(name: '_SaveExpenseController.editing', context: context);

  @override
  bool get editing {
    _$editingAtom.reportRead();
    return super.editing;
  }

  @override
  set editing(bool value) {
    _$editingAtom.reportWrite(value, super.editing, () {
      super.editing = value;
    });
  }

  late final _$paidAtom =
      Atom(name: '_SaveExpenseController.paid', context: context);

  @override
  bool get paid {
    _$paidAtom.reportRead();
    return super.paid;
  }

  @override
  set paid(bool value) {
    _$paidAtom.reportWrite(value, super.paid, () {
      super.paid = value;
    });
  }

  late final _$_SaveExpenseControllerActionController =
      ActionController(name: '_SaveExpenseController', context: context);

  @override
  dynamic setErrorMessage(dynamic value) {
    final _$actionInfo = _$_SaveExpenseControllerActionController.startAction(
        name: '_SaveExpenseController.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_SaveExpenseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEditing(bool value) {
    final _$actionInfo = _$_SaveExpenseControllerActionController.startAction(
        name: '_SaveExpenseController.setEditing');
    try {
      return super.setEditing(value);
    } finally {
      _$_SaveExpenseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
editing: ${editing},
paid: ${paid}
    ''';
  }
}
