import 'package:bank/revenue_account.dart';

import 'account.dart';

class InvestmentAccount extends RevenueAccount {
  static const investmentRate = 0.0150;
  static const investmentFrequency = 1;

  InvestmentAccount({
    required int agency,
    required int number,
    required String name,
  }) : super(
          type: AccountType.investment,
          agency: agency,
          number: number,
          name: name,
          rate: InvestmentAccount.investmentRate,
          frequency: InvestmentAccount.investmentFrequency,
        );
}
