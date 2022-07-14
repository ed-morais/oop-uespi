import 'dart:convert';
import 'dart:io';

import 'package:bank/database/database.dart';
import 'package:bank/special_account.dart';
import 'package:bank/transaction.dart';

import '../account.dart';
import 'database.dart';

class JsonDatabase implements Database {
  static const _databaseFileName = './database.json';

  static final List<Account> _accounts = [];

  @override
  void connect() {
    //loadData();
  }

  @override
  void disconnect() {
    saveData();
  }

  @override
  void loadData() {
    final file = File(_databaseFileName);
    final data = jsonDecode(file.readAsStringSync());

    _accounts.clear();
    for (var elem in _accounts) {
      //_accounts.add(Account());
    }
  }

  @override
  void saveData() async {
    final file = await File(_databaseFileName).create(recursive: true);
    final data = jsonEncode(_accounts, toEncodable: (elem) {
      Map<String, dynamic> map = {};

      if (elem is Account) {
        map['type'] = elem.type.index;
        map['agency'] = elem.agency;
        map['number'] = elem.number;
        map['name'] = elem.name;
        if (elem.type == AccountType.special) {
          map['limit'] = (elem as SpecialAccount).limit;
        }
      } else if (elem is Transaction) {
        map['type'] = TransactionType.values[elem.type.index];
        map['ammount'] = elem.ammount;
        map['date'] = elem.date.toIso8601String();
        map['description'] = elem.comment;
      }

      return map;
    });
    file.writeAsStringSync(data, flush: true);
  }
}
