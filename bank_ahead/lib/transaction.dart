enum TransactionType {
  deposit,
  withdraw,
}

typedef TransactionList = List<Transaction>;

class Transaction {
  final TransactionType type;
  final double ammount;
  final DateTime date;
  final String? comment;

  Transaction({
    required TransactionType transactionType,
    required double ammount,
    DateTime? dateTime,
    String? description,
  })  : type = transactionType,
        ammount = ammount.abs(),
        date = dateTime ?? DateTime.now(),
        comment = description;

  double get value => (type == TransactionType.deposit) ? ammount : -ammount;

  String get description {
    if (comment != null) {
      return comment!;
    }

    if (type == TransactionType.deposit) {
      return 'Depósito';
    } else if (type == TransactionType.withdraw) {
      return 'Saque';
    }
    return 'Transação desconhecida';
  }

  Map toMap() {
    return {
      'type': type.index,
      'ammount': ammount,
      'date': date.toIso8601String(),
      'comment': comment
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> json) {
    return Transaction(
      transactionType: TransactionType.values[json['type']],
      ammount: json['ammount'],
      dateTime: DateTime.parse(json['date']),
      description: json['comment'],
    );
  }
}
