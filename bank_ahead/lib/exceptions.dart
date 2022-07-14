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
