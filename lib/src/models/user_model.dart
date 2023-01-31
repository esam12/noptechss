class UserModel {
  String? userName;
  String? password;
  String? domain;
  bool? saveDomain;
  String? dbName;
  String? fullName;
  String? confirmPassword;
  String? message;
  bool? success;

  UserModel({
    this.userName,
    this.password,
    this.domain,
    this.dbName,
    this.saveDomain,
    this.fullName,
    this.confirmPassword,
    this.message,
    this.success = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      userName: parsedJson['userName'],
      dbName: parsedJson['dbName'],
      password: parsedJson['password'],
      domain: parsedJson['domain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "dbName": dbName,
      "password": password,
      "domain": domain,
    };
  }

  @override
  String toString() {
    return "UserName:$userName,dbName:$dbName,password:$password,domain:$domain,$dbName";
  }
}
