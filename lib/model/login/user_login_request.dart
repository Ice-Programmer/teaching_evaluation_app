class UserLoginRequest {
  String? userAccount;
  String? userPassword;

  UserLoginRequest({this.userAccount, this.userPassword});

  Map<String, dynamic> toJson() {
    return {'userAccount': userAccount, 'userPassword': userPassword};
  }
}
