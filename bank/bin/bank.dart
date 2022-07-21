import 'package:bank/accounts/accounts.dart';
import 'package:intl/intl.dart';

import './fake_data.dart';

void initLocale() {
  Intl.defaultLocale = 'pt_BR';
}

void main() {
  List<Account> accounts = [];

  initLocale();

  randomAccountGenerator(accounts, 5);

  // for (var account in accounts) {
  //   if (account.type == AccountType.saving ||
  //       account.type == AccountType.investment) {
  //     account.statement();
  //     break;
  //   }
  // }
}
