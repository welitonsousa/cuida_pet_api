class DataBaseConnection {
  final int port;
  final String name;
  final String user;
  final String password;
  final String host;

  DataBaseConnection({
    required this.port,
    required this.user,
    required this.name,
    required this.password,
    required this.host,
  });
}
