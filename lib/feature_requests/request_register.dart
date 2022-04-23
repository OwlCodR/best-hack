class RequestRegister {
  RequestRegister({
    required this.email,
    required this.login,
    required this.password,
    required this.name,
    required this.surname,
  });

  String email;
  String login;
  String password;
  String name;
  String surname;

  Map<String, dynamic> toJson() => {
        'email': email,
        'login': login,
        'password': password,
        'name': login,
        'surname': surname,
      };
}
