part of 'accounts.dart';

class TransactionFactory {
  static final _transactions = [
    Transaction(
      transactionType: TransactionType.deposit,
      ammount: 500.00,
      dateTime: DateTime(2022, 5, 10),
      transactionData: 'Depósito',
    ),
    Transaction(
      transactionType: TransactionType.withdraw,
      ammount: 100.00,
      dateTime: DateTime(2022, 5, 12),
      transactionData: 'Saque',
    ),
    Transaction(
      transactionType: TransactionType.withdraw,
      ammount: 200.00,
      dateTime: DateTime(2022, 5, 13),
      transactionData: 'Saque',
    ),
  ];

  static List<Transaction> makeFixedTransactions() => _transactions;
}
