part of 'accounts.dart';

enum AccountType {
  current,
  special,
  saving,
  investment,
}

typedef TransactionCallback = void Function(Transaction);
typedef DailyBalanceCallback = void Function(
    DateTime date, double dailyBalance, double totalBalance);

abstract class Account {
  static const statementLineWidth = 36;

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

  void _addTransaction(Transaction transaction) {
    final index = _transactions.indexWhere((trans) {
      return trans.date.difference(transaction.date).inDays > 0;
    });
    if (index >= 0) {
      _transactions.insert(index, transaction);
    } else {
      _transactions.add(transaction);
    }
  }

  void _addAllTransactions(List<Transaction> transactions) {
    for (var transaction in transactions) {
      _addTransaction(transaction);
    }
  }

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
      ammount: -value,
      transactionData: data,
    ));
  }

  void forEachTransaction(TransactionCallback callback) {
    for (var trans in _transactions) {
      callback(trans);
    }
  }

  void dailyBalance(DailyBalanceCallback callback, {DateTime? start}) {
    if (_transactions.isEmpty) {
      return;
    }

    DateTime lastDate = dateOnly(start ?? _transactions.first.date);
    int lastIndex = _transactions.length - 1;
    double totalBalance = 0.00;
    double dailyBalance = 0.00;

    for (int i = 0; i < _transactions.length; i++) {
      Transaction transaction = _transactions[i];

      if ((transaction.date.difference(lastDate).inDays > 0) ||
          (i == lastIndex)) {
        if (i == lastIndex) {
          dailyBalance += transaction.value;
          totalBalance += transaction.value;
        }

        callback(lastDate, dailyBalance, totalBalance);

        lastDate = dateOnly(transaction.date);
        dailyBalance = 0.00;
      }
      dailyBalance += transaction.value;
      totalBalance += transaction.value;
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
    String date;
    String text;
    String value;
    double balance = 0.00;

    text = formatString(
      'BANCO EXEMPLO S/A',
      statementLineWidth,
      alignment: StringAlignment.center,
    );
    print(text);

    text = formatString(
      'EXTRATO DE CONTA ${_typeStringPtBr.toUpperCase()}',
      statementLineWidth,
      alignment: StringAlignment.center,
    );
    print(text);

    text = formatString('AG.$agency/NC.$number', statementLineWidth - 10);
    date = formatString(
      dateToDDMMYY(DateTime.now()),
      statementLineWidth - text.length,
      alignment: StringAlignment.right,
    );
    print('$text$date');

    print('-' * statementLineWidth);

    text = formatString(
      'DATA  DESCRIÇÃO',
      statementLineWidth - 10,
    );
    value = formatString(
      'VALOR',
      statementLineWidth - text.length,
      alignment: StringAlignment.right,
    );
    print('$text$value');

    for (var trans in _transactions) {
      balance += trans.value;

      date = dateToDDMM(trans.date);
      value = formatNumber(trans.value, 10);
      text = formatString(
        trans.description,
        statementLineWidth - date.length - value.length - 2,
      );

      print('$date $text $value');
    }
    print('-' * statementLineWidth);

    date = dateToDDMM(DateTime.now());
    value = formatNumber(balance, 10);
    text = formatString(
      'SALDO',
      statementLineWidth - value.length - date.length - 2,
    );
    print('$date $text $value');
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

  String get _typeStringPtBr {
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

  @override
  String toString() => '$_typeString($name)';
}
