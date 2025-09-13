import 'package:teaching_evaluation_app/http/base_response.dart';
import 'package:teaching_evaluation_app/model/login/user_info.dart';

class UserLoginResponse {
  final UserInfo? userInfo;
  final String? token;
  final int? expireAt; // i64 -> int
  final BaseResp baseResp;

  UserLoginResponse({
    this.userInfo,
    this.token,
    this.expireAt,
    required this.baseResp,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      userInfo:
          json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null,
      token: json['token'] as String?,
      expireAt: json['expireAt'] as int?,
      baseResp: BaseResp.fromJson(json['BaseResp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userInfo': userInfo?.toJson(),
      'token': token,
      'expireAt': expireAt,
      'BaseResp': baseResp.toJson(),
    };
  }
}
