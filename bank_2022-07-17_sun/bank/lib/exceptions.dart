part of 'accounts.dart';

class TransactionError {
  @override
  String toString() => 'Transaction error';

  String get message => toString();
}

class InvalidTransactionValueError extends TransactionError {
  @override
  String toString() => 'Invalid transaction error';
}

class InsuficientFundsError extends TransactionError {
  @override
  String toString() => 'Insuficient funds';
}

class InvalidSourceAccountError extends TransactionError {
  @override
  String toString() =>
      'Conta de origem inválida (mesma conta de origem e destino)';
}
