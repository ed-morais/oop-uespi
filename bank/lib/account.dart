import 'package:bank/exceptions.dart';
import 'package:bank/helpers.dart';

import 'transaction.dart';

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

  final List<Transaction> _transactions = [];

  Account.open({
    required this.type,
    required this.agency,
    required this.number,
    required this.name,
  });

  void _addTransaction(Transaction transaction) =>
      _transactions.add(transaction);

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

    return _transactions.fold<double>(
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
    Transaction trans;

    if (this == sourceAccount) {
      throw InvalidSourceAccountError();
    }

    trans = Transaction(
      transactionType: TransactionType.transfer,
      ammount: value,
      transactionData: '$agency/$number',
    );
    sourceAccount.withdraw(value, transaction: trans);

    trans = Transaction(
      transactionType: TransactionType.transfer,
      ammount: value,
      transactionData: '${sourceAccount.agency}/${sourceAccount.number}',
    );
    deposit(value, transaction: trans);
  }

  void payment(double value, {String? document}) {
    Transaction trans;

    trans = Transaction(
      transactionType: TransactionType.payment,
      ammount: value,
      transactionData: document,
    );
    withdraw(value, transaction: trans);
  }

  void statement() {
    String date;
    String desc;
    String value;
    double balance = 0.00;

    print('          BANCO EXEMPLO  S/A');
    print('           EXTRATO DE CONTA');
    print('-------------------------------------');
    print('DATA  DESCRIÇÃO                 VALOR');

    for (var trans in _transactions) {
      balance += trans.value;

      date = dateToDDMM(trans.date);
      desc = stringWidth(trans.description, 20);
      value = formatNumber(trans.value, 10);

      print('$date $desc $value');
    }
    print('-------------------------------------');

    date = dateToDDMM(DateTime.now());
    desc = stringWidth('SALDO', 20);
    value = formatNumber(balance, 10);
    print('$date $desc $value');
  }

  void close();

  String get _typeString {
    switch (type) {
      case AccountType.current:
        return 'Current';
      case AccountType.special:
        return 'Special';
      case AccountType.saving:
        return 'Saving';
      case AccountType.investment:
        return 'Investment';
    }
  }

  @override
  String toString() => '$_typeString($name)';
}
