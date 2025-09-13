import 'package:dio/dio.dart';
import 'package:teaching_evaluation_app/http/business_exception.dart';
import 'package:teaching_evaluation_app/http/dio_instance.dart';
import 'package:teaching_evaluation_app/http/http_constant.dart';
import 'package:teaching_evaluation_app/model/login/user_login_request.dart';
import 'package:teaching_evaluation_app/model/login/user_login_response.dart';

class LoginService {
  final DioInstance _dioInstance = DioInstance.instance();

  Future<UserLoginResponse> userPasswordLogin(UserLoginRequest request) async {
    try {
      final response = await _dioInstance.post(
        path: '/user/login',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );

      final baseResponse = UserLoginResponse.fromJson(response.data);

      if (baseResponse.baseResp.statusCode == HttpConstant.successCode) {
        return baseResponse;
      } else {
        // 抛出业务异常
        throw BusinessException('登录失败: ${baseResponse.baseResp.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
