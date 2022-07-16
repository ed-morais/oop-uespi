import 'package:bank/exceptions.dart';
import 'package:bank/helpers.dart';

import 'transaction.dart';

enum AccountType {
  current,
  special,
  saving,
  investment,
}

typedef TransactionCallback = void Function(Transaction);

abstract class Account {
  static const debugMode = true;

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

  void credit({
    required double value,
    required TransactionType type,
    String? data,
  }) {
    _checkTransactionValue(value);

    _addTransaction(Transaction(
      transactionType: type,
      dateTime: debugMode ? randomDateTime() : null,
      ammount: value,
      transactionData: data,
    ));
  }

  void debit({
    required double value,
    required TransactionType type,
    String? data,
  }) {
    _checkTransactionValue(value);

    if (value > balance()) {
      throw InsuficientFundsError();
    }

    _addTransaction(Transaction(
      transactionType: TransactionType.withdraw,
      dateTime: debugMode ? randomDateTime() : null,
      ammount: value,
      transactionData: data,
    ));
  }

  void sortTransactions() {
    if (debugMode) {
      _transactions.sort((t1, t2) => t1.date.compareTo(t2.date));
    }
  }

  void forEachTransaction(TransactionCallback callback) {
    for (var trans in _transactions) {
      callback(trans);
    }
  }

  double balance() {
    return _transactions.fold<double>(
      0.0,
      (value, trans) => value + trans.value,
    );
  }

  void deposit(double value) {
    credit(value: value, type: TransactionType.deposit);
  }

  void withdraw(double value) {
    debit(value: value, type: TransactionType.withdraw);
  }

  void transfer(Account sourceAccount, double value) {
    if (this == sourceAccount) {
      throw InvalidSourceAccountError();
    }

    sourceAccount.debit(
      value: value,
      type: TransactionType.transfer,
      data: '$agency/$number',
    );

    credit(
      value: value,
      type: TransactionType.transfer,
      data: '${sourceAccount.agency}/${sourceAccount.number}',
    );
  }

  void payment(double value, {String? document}) {
    debit(
      value: value,
      type: TransactionType.payment,
      data: document,
    );
  }

  void statement() {
    String date;
    String desc;
    String value;
    double balance = 0.00;

    desc = formatString('AG.$agency/NC.$number', 29);
    date = dateToDDMMYY(DateTime.now());

    print('          BANCO EXEMPLO  S/A');
    print('           EXTRATO DE CONTA');
    print('$desc$date');
    print('-------------------------------------');
    print('DATA  DESCRIÇÃO                 VALOR');

    for (var trans in _transactions) {
      balance += trans.value;

      date = dateToDDMM(trans.date);
      desc = formatString(trans.description, 20);
      value = formatNumber(trans.value, 10);

      print('$date $desc $value');
    }
    print('-------------------------------------');

    date = dateToDDMM(DateTime.now());
    desc = formatString('SALDO', 20);
    value = formatNumber(balance, 10);
    print('$date $desc $value');
  }

  void close() {}

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
