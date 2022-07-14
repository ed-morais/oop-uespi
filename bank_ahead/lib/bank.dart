import './account.dart';
import './current_account.dart';
import './special_account.dart';

void showBalances(List<Account> accounts) {
  for (var account in accounts) {
    print('$account: ${account.balance()}');
  }
  print('-------------------------');
}

void main() {
  Account c1 = CurrentAccount(
    agency: 232,
    number: 43643,
    name: 'Current1',
  );
  Account c2 = CurrentAccount(
    agency: 232,
    number: 45342,
    name: 'Current2',
  );
  Account s1 = SpecialAccount(
    agency: 232,
    number: 45342,
    name: 'Special1',
    limitAmmount: 1000.00,
  );

  showBalances([c1, c2, s1]);

  c1.deposit(100.00);
  s1.deposit(200.00);
  showBalances([c1, s1]);

  c1.withdraw(100.00);
  s1.withdraw(800.00);
  showBalances([c1, s1]);

  s1.transfer(c1, 200.00);
  showBalances([c1, s1]);
}
