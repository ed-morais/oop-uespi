part of './accounts.dart';

enum AccountType {
  current,
  special,
  saving,
  investment,
}

typedef TransactionCallback = void Function(Transaction);

abstract class Account {
  static const statementWidth = 38;
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

  void _credit({
    required double value,
    required TransactionType type,
    String? data,
  }) {
    _checkTransactionValue(value);

    _addTransaction(Transaction(
      transactionType: type,
      dateTime: debugMode ? DateTimeFactory.random() : null,
      ammount: value,
      transactionData: data,
    ));
  }

  void _debit({
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
      dateTime: debugMode ? DateTimeFactory.random() : null,
      ammount: value,
      transactionData: data,
    ));
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
    _credit(value: value, type: TransactionType.deposit);
  }

  void withdraw(double value) {
    _debit(value: value, type: TransactionType.withdraw);
  }

  void transfer(Account sourceAccount, double value) {
    if (this == sourceAccount) {
      throw InvalidSourceAccountError();
    }

    sourceAccount._debit(
      value: value,
      type: TransactionType.transfer,
      data: '$agency/$number',
    );

    _credit(
      value: value,
      type: TransactionType.transfer,
      data: '${sourceAccount.agency}/${sourceAccount.number}',
    );
  }

  void payment(double value, {String? document}) {
    _debit(
      value: value,
      type: TransactionType.payment,
      data: document,
    );
  }

  void statement() {
    String text1;
    String text2;
    String value;
    double balance = 0.00;

    print(alignString(
      'BANCO EXEMPLO  S/A',
      statementWidth,
      align: StringAlignment.center,
    ));
    print(alignString(
      'EXTRATO DE CONTA ${typeString.toUpperCase()}',
      statementWidth,
      align: StringAlignment.center,
    ));

    text1 = dateToDDMMYY(DateTime.now());
    text2 = alignString(
      'AG.$agency/NC.$number',
      statementWidth - text1.length,
    );
    print('$text2$text1');

    print('-' * statementWidth);

    text2 = 'VALOR';
    text1 = alignString('DATA  DESCRIÇÃO', statementWidth - text2.length);
    print('$text1$text2');

    for (var trans in _transactions) {
      balance += trans.value;

      text1 = dateToDDMM(trans.date);
      value = formatNumber(trans.value, 10);
      text2 = alignString(
        trans.description,
        statementWidth - text1.length - value.length - 1,
      );
      print('$text1 $text2$value');
    }
    print('-' * statementWidth);

    text1 = dateToDDMM(DateTime.now());
    value = formatNumber(balance, 10);
    text2 = alignString(
      'SALDO',
      statementWidth - text1.length - value.length - 1,
    );
    print('$text1 $text2$value');
  }

  void close() {}

  String get typeString {
    switch (type) {
      case AccountType.current:
        return 'Corrente';
      case AccountType.special:
        return 'Especial';
      case AccountType.saving:
        return 'Poupança';
      case AccountType.investment:
        return 'Investimento';
    }
  }

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
