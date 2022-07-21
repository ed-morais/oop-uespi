part of 'accounts.dart';

abstract class RevenueAccount extends Account {
  final double rate;
  final int frequency;

  RevenueAccount({
    required AccountType type,
    required int agency,
    required int number,
    required String name,
    required this.rate,
    required this.frequency,
  }) : super.open(
          type: type,
          agency: agency,
          number: number,
          name: name,
        );

  double _calculateInterest(double value, int frequencyInDays) {
    if (frequencyInDays < frequency) {
      return 0.00;
    }
    return doubleToCurrency(value * rate * frequency);
  }

  @override
  void statement() {
    super.statement();

    final value = formatNumber(rate * 100.00, 10, addSuffix: false);
    final desc = formatString(
      'TAXA DE JUROS',
      Account.statementLineWidth - value.length - 8,
    );
    print('      $desc $value%');
  }

  void calculateInterests() {
    if (_transactions.isEmpty) {
      return;
    }

    List<Transaction> interestTransactions = [];
    DateTime refDate = _transactions.first.date;
    DateTime lastDate = refDate;
    double sum = 0.00;
    int index = 0;

    while (index < _transactions.length) {
      Transaction transaction = _transactions[index];
      int days = transaction.date.difference(refDate).inDays;

      if ((days > frequency) || (index == _transactions.length - 1)) {
        if (sum > 0.00) {
          final interest = _calculateInterest(sum, days);

          if (interest > 0.00) {
            refDate = DateTime(lastDate.year, lastDate.month, lastDate.day);
            interestTransactions.add(Transaction(
              transactionType: TransactionType.interest,
              dateTime: refDate,
              ammount: interest,
            ));
            sum = 0.00;
          }
        }
      }
      sum += transaction.value;

      lastDate = transaction.date;

      index++;
    }
    _addAllTransactions(interestTransactions);
  }
}
