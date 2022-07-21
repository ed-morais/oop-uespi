part of 'accounts.dart';

class SpecialAccount extends Account {
  final double limit;

  SpecialAccount({
    required int agency,
    required int number,
    required String name,
    required double limitValue,
  })  : limit = limitValue,
        super.open(
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
  void statement() {
    super.statement();

    String date = ''.padLeft(5);
    String value = formatNumber(limit, 10);
    String desc = formatString(
      'LIMITE',
      Account.statementLineWidth - date.length - value.length - 2,
    );

    print('$date $desc $value');

    date = dateToDDMM(DateTime.now());
    value = formatNumber(balance(), 10);
    desc = formatString(
      'DISPONÍVEL',
      Account.statementLineWidth - date.length - value.length - 2,
    );

    print('$date $desc $value');
  }

  @override
  void close() {}
}
