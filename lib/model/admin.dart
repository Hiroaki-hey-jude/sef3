class Admin{
  Admin._();
  // make only one instance
  static final instance = Admin._();

  String? adminId;
  String? adminName;
  String? adminPassword;
  String? adminEmail;
}