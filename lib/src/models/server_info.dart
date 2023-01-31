class ServerInfo {
  String host;
  int port;
  String dbName;
  ServerInfo(this.host, this.port, this.dbName);
  @override
  String toString() {
    return "{ ServerInfo:{ host:$host, port:$port, dbName:$dbName} }";
  }
}
