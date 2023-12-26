// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_expense_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SaveExpenseController on _SaveExpenseController, Store {
  Computed<bool>? _$editingComputed;

  @override
  bool get isEdit => (_$editingComputed ??= Computed<bool>(() => super.isEdit,
          name: '_SaveExpenseController.editing'))
      .value;

  late final _$editingIdAtom =
      Atom(name: '_SaveExpenseController.editingId', context: context);

  @override
  int? get editingId {
    _$editingIdAtom.reportRead();
    return super.editingId;
  }

  @override
  set editingId(int? value) {
    _$editingIdAtom.reportWrite(value, super.editingId, () {
      super.editingId = value;
    });
  }

  late final _$descriptionErrorAtom =
      Atom(name: '_SaveExpenseController.descriptionError', context: context);

  @override
  String? get descriptionError {
    _$descriptionErrorAtom.reportRead();
    return super.descriptionError;
  }

  @override
  set descriptionError(String? value) {
    _$descriptionErrorAtom.reportWrite(value, super.descriptionError, () {
      super.descriptionError = value;
    });
  }

  late final _$amountErrorAtom =
      Atom(name: '_SaveExpenseController.amountError', context: context);

  @override
  String? get amountError {
    _$amountErrorAtom.reportRead();
    return super.amountError;
  }

  @override
  set amountError(String? value) {
    _$amountErrorAtom.reportWrite(value, super.amountError, () {
      super.amountError = value;
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
  dynamic setEditingId(dynamic value) {
    final _$actionInfo = _$_SaveExpenseControllerActionController.startAction(
        name: '_SaveExpenseController.setEditingId');
    try {
      return super.setEditingId(value);
    } finally {
      _$_SaveExpenseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDescriptionError(String? value) {
    final _$actionInfo = _$_SaveExpenseControllerActionController.startAction(
        name: '_SaveExpenseController.setDescriptionError');
    try {
      return super.setDescriptionError(value);
    } finally {
      _$_SaveExpenseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAmountError(String? value) {
    final _$actionInfo = _$_SaveExpenseControllerActionController.startAction(
        name: '_SaveExpenseController.setAmountError');
    try {
      return super.setAmountError(value);
    } finally {
      _$_SaveExpenseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPaid(bool value) {
    final _$actionInfo = _$_SaveExpenseControllerActionController.startAction(
        name: '_SaveExpenseController.setPaid');
    try {
      return super.setPaid(value);
    } finally {
      _$_SaveExpenseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
editingId: ${editingId},
descriptionError: ${descriptionError},
amountError: ${amountError},
paid: ${paid},
editing: ${isEdit}
    ''';
  }
}
