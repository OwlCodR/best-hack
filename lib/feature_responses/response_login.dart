class ResponseLogin {
  ResponseLogin({required this.uuid});

  String uuid;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(uuid: json['userUUID']);
  }
}
