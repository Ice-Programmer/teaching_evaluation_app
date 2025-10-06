import 'package:dio/dio.dart';
import 'package:teaching_evaluation_app/http/business_exception.dart';
import 'package:teaching_evaluation_app/http/dio_instance.dart';
import 'package:teaching_evaluation_app/http/http_constant.dart';
import 'package:teaching_evaluation_app/model/login/get_current_user_response.dart';
import 'package:teaching_evaluation_app/model/login/user_login_request.dart';
import 'package:teaching_evaluation_app/model/login/user_login_response.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

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
        ToastUtils.showErrorMsg('登录失败: ${baseResponse.baseResp.statusMessage}');
        // 抛出业务异常
        throw BusinessException('登录失败: ${baseResponse.baseResp.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<GetCurrentUserResponse> getCurrentLoginUser() async {
    try {
      final response = await _dioInstance.post(path: '/user/current', data: {});

      final baseResponse = GetCurrentUserResponse.fromJson(response.data);

      if (baseResponse.baseResp.statusCode == HttpConstant.successCode) {
        return baseResponse;
      } else {
        ToastUtils.showErrorMsg(
          '获取当前用户失败: ${baseResponse.baseResp.statusMessage}',
        );
        // 抛出业务异常
        throw BusinessException(
          '获取当前用户失败: ${baseResponse.baseResp.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
