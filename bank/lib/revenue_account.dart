import 'package:bank/transaction.dart';

import './account.dart';
import './helpers.dart';

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

  double _calculateInterest(double value) => value * rate * frequency;

  @override
  void statement() {
    super.statement();

    final frate = formatNumber(rate * 100.00, 10, addSuffix: false);
    final desc = formatString('TAXA DE JUROS', 20);
    print('      $desc$frate%');
  }

  void calculateInterests() {
    List<Transaction> transactions = [];
    double sum = 0.00;
    DateTime? lastDate;

    forEachTransaction((trans) {
      if (lastDate != null) {
        final days = trans.date.difference(lastDate!).inDays;
        if (days > frequency) {
          if (sum > 0.00) {
            transactions.add(Transaction(
              transactionType: TransactionType.interest,
              ammount: _calculateInterest(sum),
            ));
          }
          sum = trans.value;
        } else {
          sum += trans.value;
        }
      } else {
        lastDate = trans.date;
      }
    });

    for (var trans in transactions) {
      credit(
        value: trans.ammount,
        type: TransactionType.interest,
      );
    }

    sortTransactions();
  }
}
