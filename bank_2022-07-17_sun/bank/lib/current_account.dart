part of 'accounts.dart';

class CurrentAccount extends Account {
  CurrentAccount({
    required int agency,
    required int number,
    required String name,
  }) : super.open(
          type: AccountType.current,
          agency: agency,
          number: number,
          name: name,
        );

  @override
  void close() {}
}
