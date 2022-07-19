part of './accounts.dart';

enum TransactionType {
  deposit,
  withdraw,
  transfer,
  payment,
  interest,
}

class Transaction {
  final TransactionType type;
  final double ammount;
  final DateTime date;
  final String? data;

  Transaction({
    required TransactionType transactionType,
    required double ammount,
    DateTime? dateTime,
    String? transactionData,
  })  : type = transactionType,
        ammount = ammount.abs(),
        date = dateTime ?? DateTime.now(),
        data = transactionData;

  double get value => (type == TransactionType.deposit) ? ammount : -ammount;

  String get description {
    switch (type) {
      case TransactionType.deposit:
        return 'Depósito';
      case TransactionType.withdraw:
        return 'Saque';
      case TransactionType.transfer:
        return 'Transf ${data ?? ""}';
      case TransactionType.payment:
        return 'Pagamento ${data ?? ""}';
      case TransactionType.interest:
        return 'Juros';
      default:
        return 'Transação desconhecida';
    }
  }
}
