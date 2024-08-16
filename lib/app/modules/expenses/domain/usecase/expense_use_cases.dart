import 'package:fpdart/fpdart.dart';
import 'package:myselff_flutter/app/core/exceptions/database_exception.dart';

import '../entity/expense_entity.dart';
import '../entity/payment_type_entity.dart';
import '../repository/expense_repository.dart';

class ExpenseUseCases {
  final ExpenseRepository _repository;

  const ExpenseUseCases(this._repository);

  Future<Either<LocalDatabaseException, List<ExpenseEntity>>> getExpensesByYearMonth({required int year, required int month}) {
    // returns a list of expenses filtering by the given year and month
    return _repository.getExpensesByYearMonth(year: year, month: month);
  }

  Future<Either<LocalDatabaseException, void>> saveExpense({required ExpenseEntity expenseEntity}) async {
    // validates the expense data
    // case of description is empty
    if (expenseEntity.description.trim().isEmpty) {
      return Left(LocalDatabaseException('Preencha a descrição'));
    }

    // value of amount is less than or equal to zero
    if (expenseEntity.amount <= 0) {
      return Left(LocalDatabaseException('O valor deve ser maior que zero'));
    }


    // BR1: by expense marked as not paid, payment type must be null
    if (!expenseEntity.paid) {
      expenseEntity.paymentType = null;
    }

    // check if the expense has already been saved (by containing a non-empty id)
    if (expenseEntity.id == null) {
      // if the expense doesn't have an id, it will be inserted
      return _repository.insertExpense(expenseEntity: expenseEntity);
    } else {
      // otherwise, it will be updated
      return _repository.updateExpense(expenseEntity: expenseEntity);
    }
  }

  Future<Either<LocalDatabaseException, void>> deleteExpense({required int expenseId}) async {
    // deletes the expense by the given id
    return _repository.deleteExpense(expenseId: expenseId);
  }

  Future<Either<LocalDatabaseException, void>> markAsPaid({required ExpenseEntity expenseEntity}) async {
    // switch the boolean property "paid" of expense to true
    expenseEntity.paid = true;
    // updates the expense
    return _repository.updateExpense(expenseEntity: expenseEntity);
  }

  Future<Either<LocalDatabaseException, void>> setPaymentTypeForExpense({
    required ExpenseEntity expenseEntity,
    required PaymentTypeEntity? paymentTypeEntity,
  }) async {
    // set the payment type of expense
    if (paymentTypeEntity == PaymentTypeEntity.none()) {
      expenseEntity.paymentType = null;
    } else {
      expenseEntity.paymentType = paymentTypeEntity;
    }
    // updates the expense
    return _repository.updateExpense(expenseEntity: expenseEntity);
  }

  Future<Either<LocalDatabaseException, ExpenseEntity?>> getById({required int? expenseId}) async {
    // retrieve the expense by the given id
    return _repository.getExpenseById(expenseId: expenseId);
  }
}
