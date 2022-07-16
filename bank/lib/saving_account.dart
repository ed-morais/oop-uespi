import 'package:bank/revenue_account.dart';

import 'account.dart';

class SavingAccount extends RevenueAccount {
  static const savingRate = 0.0085;
  static const savingFrequency = 30;

  SavingAccount({
    required int agency,
    required int number,
    required String name,
  }) : super(
          type: AccountType.saving,
          agency: agency,
          number: number,
          name: name,
          rate: SavingAccount.savingRate,
          frequency: SavingAccount.savingFrequency,
        );
}
