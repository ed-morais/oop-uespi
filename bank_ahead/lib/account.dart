import 'package:bank/exceptions.dart';

import 'transaction.dart';
import 'transaction_factory.dart';

enum AccountType {
  current,
  special,
  saving,
  investment,
}

abstract class Account {
  final AccountType type;
  final int agency;
  final int number;
  final String name;

  final TransactionList transactions = [];

  Account({
    required this.type,
    required this.agency,
    required this.number,
    required this.name,
  }) {
    transactions.addAll(TransactionFactory.makeFixedTransactions());
  }

  @override
  String toString() => 'Account($name)';

  void _addTransaction(Transaction transaction) =>
      transactions.add(transaction);

  void _checkTransactionValue(double value) {
    if (value.isNegative) {
      throw InvalidTransactionValueError();
    }
  }

  double balance() {
    /*
    double sum = 0.00;

    for (int i = 0; i < _transactions.length; i++) {
      sum += _transactions[i].value;
    }

    for (var trans in _transactions) {
      sum += trans.value;
    }

    _transactions.forEach((trans) {
      sum += trans.value;
    });
    */

    return transactions.fold<double>(
      0.0,
      (value, trans) => value + trans.value,
    );
  }

  void deposit(double value, {Transaction? transaction}) {
    _checkTransactionValue(value);

    transaction ??= Transaction(
      transactionType: TransactionType.deposit,
      ammount: value,
    );

    _addTransaction(transaction);
  }

  void withdraw(double value, {Transaction? transaction}) {
    _checkTransactionValue(value);

    if (value > balance()) {
      throw InsuficientFundsError();
    }

    transaction ??= Transaction(
      transactionType: TransactionType.withdraw,
      ammount: value,
    );

    _addTransaction(transaction);
  }

  void transfer(Account sourceAccount, double value) {
    sourceAccount.withdraw(
      value,
      transaction: Transaction(
        transactionType: TransactionType.withdraw,
        ammount: value,
        description: 'Transf p/ $agency/$number',
      ),
    );
    deposit(
      value,
      transaction: Transaction(
          transactionType: TransactionType.withdraw,
          ammount: value,
          description:
              'Transf de ${sourceAccount.agency}/${sourceAccount.number}'),
    );
  }

  void close();
  void statement();
}
