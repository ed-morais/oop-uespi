import 'package:faker/faker.dart';

import './account.dart';
import './current_account.dart';
import './special_account.dart';

void showBalances(List<Account> accounts) {
  for (var account in accounts) {
    print('$account: ${account.balance()}');
  }
  print('-------------------------');
}

void randomAccountGenerator(List<Account> accounts, int count) {
  final faker = Faker();

  while (count > 0) {
    int t = faker.randomGenerator.integer(AccountType.values.length);
    AccountType accountType = AccountType.values[t];
    Account? account;

    final agency = faker.randomGenerator.integer(1000, min: 100);
    final number = faker.randomGenerator.integer(10000, min: 1000);
    final name = faker.person.name();

    switch (accountType) {
      case AccountType.current:
        account = CurrentAccount(
          agency: agency,
          number: number,
          name: name,
        );
        break;
      case AccountType.special:
        account = SpecialAccount(
          agency: agency,
          number: number,
          name: name,
          limitAmmount: faker.randomGenerator.integer(101, min: 1) * 100,
        );
        break;
      default:
        account = null;
    }

    if (account != null) {
      accounts.add(account);
      count--;
    }
  }
}

void randomTransactionGenerator(List<Account> accounts,
    {int min = 0, int max = 0}) {}

void main() {
  List<Account> accounts = [];

  randomAccountGenerator(accounts, 5);
  randomTransactionGenerator(accounts, min: 5, max: 10);

  for (var account in accounts) {
    account.statement();
  }
}
