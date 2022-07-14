typedef TableField = Map<String, dynamic>;

abstract class Database {
  void connect();
  void disconnect();

  void loadData();
  void saveData();
}
