import 'package:bank/revenue_account.dart';
import 'package:bank/saving_account.dart';
import 'package:faker/faker.dart';

import './account.dart';
import './current_account.dart';
import './special_account.dart';
import './investment_account.dart';
import './transaction.dart';

void showBalances(List<Account> accounts) {
  for (var account in accounts) {
    print('$account: ${account.balance()}');
  }
  print('-------------------------');
}

double randomValue(int balance) {
  return faker.randomGenerator.integer(balance, min: 1) / 100.00;
}

void randomTransactionGenerator(
  List<Account> accounts,
  Account account,
  int count,
) {
  while (count > 0) {
    TransactionType type;
    double value;
    int balance;
    bool newTransaction;

    balance = (account.balance() * 100).toInt();
    if (balance > 0) {
      int t = faker.randomGenerator.integer(TransactionType.values.length);
      type = TransactionType.values[t];
      if ((accounts.length == 1) && (type == TransactionType.transfer)) {
        continue;
      }
    } else {
      type = TransactionType.deposit;
    }

    newTransaction = true;
    switch (type) {
      case TransactionType.deposit:
        value = randomValue(100000);
        account.deposit(value);
        break;
      case TransactionType.withdraw:
        value = randomValue(balance + 1);
        account.withdraw(value);
        break;
      case TransactionType.transfer:
        final otherAccounts = [...accounts];
        otherAccounts.remove(account);
        final i = faker.randomGenerator.integer(otherAccounts.length);
        final otherAccount = otherAccounts[i];
        balance = (otherAccount.balance() * 100).toInt();
        if (balance >= 0.00) {
          value = randomValue(balance + 1);
          account.transfer(otherAccount, value);
        } else {
          count++;
        }
        break;
      case TransactionType.payment:
        value = randomValue(balance + 1);
        account.payment(value,
            document: faker.randomGenerator.numberOfLength(10));
        break;
      default:
        newTransaction = false;
        count++;
    }
    count--;

    if (account is RevenueAccount) {
      account.calculateInterests();
    }
  }
  account.sortTransactions();
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
          limitValue: faker.randomGenerator.integer(101, min: 1) * 100,
        );
        break;
      case AccountType.saving:
        account = SavingAccount(
          agency: agency,
          number: number,
          name: name,
        );
        break;
      case AccountType.investment:
        account = InvestmentAccount(
          agency: agency,
          number: number,
          name: name,
        );
        break;
      default:
        account = null;
    }

    if (account != null) {
      accounts.add(account);

      randomTransactionGenerator(
        accounts,
        account,
        faker.randomGenerator.integer(15, min: 1),
      );
      count--;
    }
  }
}

void main() {
  List<Account> accounts = [];

  randomAccountGenerator(accounts, 5);

  for (var account in accounts) {
    if (account.type == AccountType.saving ||
        account.type == AccountType.investment) {
      account.statement();
      break;
    }
  }
}
