import './transaction.dart';

class TransactionFactory {
  static final _transactions = [
    Transaction(
      transactionType: TransactionType.deposit,
      ammount: 500.00,
      dateTime: DateTime(2022, 5, 10),
      description: 'Depósito',
    ),
    Transaction(
      transactionType: TransactionType.withdraw,
      ammount: 100.00,
      dateTime: DateTime(2022, 5, 12),
      description: 'Saque',
    ),
    Transaction(
      transactionType: TransactionType.withdraw,
      ammount: 200.00,
      dateTime: DateTime(2022, 5, 13),
      description: 'Saque',
    ),
  ];

  static List<Transaction> makeFixedTransactions() => _transactions;
}
