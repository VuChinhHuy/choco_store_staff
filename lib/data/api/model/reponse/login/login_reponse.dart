class LoginReponse {
  String? token;
  Account? account;
  // String? role;

  @override
  String toString() {
    return 'LoginRepose: token: $token';
  }

  // contrustor
  LoginReponse({this.token, this.account});
  factory LoginReponse.fromJson(Map<String, dynamic> json) {
    return LoginReponse(
        token: json['token'], account: Account.fromJson(json['account']));
  }
  Map<String, dynamic> toJson() {
    Account acc = Account(id: account!.id, username: account!.username);
    return {"token": token, "account": acc.toJson()};
  }
}

class Account {
  String? id;
  String? username;
  Account({this.id, this.username});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(id: json['id'], username: json['username']);
  }
  Map<String, dynamic> toJson() => {"id": id, "username": username};
}
