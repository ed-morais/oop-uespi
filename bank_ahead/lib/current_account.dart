import './account.dart';

class CurrentAccount extends Account {
  CurrentAccount({
    required int agency,
    required int number,
    required String name,
  }) : super(
          type: AccountType.current,
          agency: agency,
          number: number,
          name: name,
        );

  @override
  Account fromMap(Map map) {
    final account = CurrentAccount(
      agency: map['agency'],
      number: map['number'],
      name: map['name'],
    );
    // account.transactions.addAll(jsonDecode(source));
    return account;
  }

  @override
  Map toMap() {
    return {
      'type': type,
      'agency': agency,
      'number': number,
      'name': name,
      'transactions': transactions,
    };
  }

  @override
  void close() {}

  @override
  void statement() {}
}
