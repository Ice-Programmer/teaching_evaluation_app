import 'package:teaching_evaluation_app/http/base_response.dart';
import 'package:teaching_evaluation_app/model/login/user_info.dart';

class GetCurrentUserResponse {
  final UserInfo? userInfo;
  final BaseResp baseResp;

  GetCurrentUserResponse({this.userInfo, required this.baseResp});

  factory GetCurrentUserResponse.fromJson(Map<String, dynamic> json) {
    return GetCurrentUserResponse(
      userInfo:
          json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null,
      baseResp: BaseResp.fromJson(json['BaseResp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'userInfo': userInfo?.toJson(), 'BaseResp': baseResp.toJson()};
  }
}
