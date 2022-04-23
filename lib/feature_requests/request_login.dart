class RequestLogin {
  String login;
  String password;

  RequestLogin({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'login': login,
        'password': password,
      };
}
