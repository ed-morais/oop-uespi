import 'account.dart';

class SpecialAccount extends Account {
  final double limit;

  SpecialAccount({
    required int agency,
    required int number,
    required String name,
    required double limitAmmount,
  })  : limit = limitAmmount,
        super(
          type: AccountType.special,
          agency: agency,
          number: number,
          name: name,
        );

  @override
  double balance() {
    return super.balance() + limit;
  }

  @override
  void close() {}

  @override
  void statement() {}

  @override
  Account fromMap(Map map) {
    final account = SpecialAccount(
        agency: map['agency'],
        number: map['number'],
        name: map['name'],
        limitAmmount: map['limit']);
    return account;
  }

  @override
  Map toMap() {
    return {
      'type': type,
      'agency': agency,
      'number': number,
      'name': name,
      'limit': limit,
      'transactions': transactions,
    };
  }
}
