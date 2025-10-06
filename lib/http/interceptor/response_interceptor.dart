import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teaching_evaluation_app/http/base_response.dart';
import 'package:teaching_evaluation_app/http/business_exception.dart';
import 'package:teaching_evaluation_app/utils/log_util.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;

    if (data is Map && data.containsKey('BaseResp')) {
      LogUtils.println(data.toString());
      BaseResp baseResp = BaseResp.fromJson(data['BaseResp']);
      final message = baseResp.statusMessage;
      // // 判断业务状态码
      // if (baseResp.statusCode != HttpConstant.successCode) {
      //   ToastUtils.showErrorMsg(message);

      //   // 直接抛出业务异常
      //   handler.reject(
      //     DioException(
      //       requestOptions: response.requestOptions,
      //       error: BusinessException(message, baseResp.statusCode),
      //       response: response,
      //       type: DioExceptionType.badResponse,
      //     ),
      //   );
      //   return;
      // }
    }

    // 正常返回
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 先处理业务异常
    if (err.error is BusinessException) {
      final be = err.error as BusinessException;
      final msg = be.message;
      ToastUtils.showErrorMsg(msg);
      debugPrint("业务异常: $msg, code=${be.statusCode}");
    } else {
      // 网络异常
      String errorMessage = "请检查网络";
      if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.sendTimeout) {
        errorMessage = "连接超时，请检查网络连接";
      } else if (err.type == DioExceptionType.receiveTimeout) {
        errorMessage = "服务器响应超时，请稍后重试";
      } else if (err.response?.statusCode == 404) {
        errorMessage = "请求的资源不存在";
      } else if (err.type == DioExceptionType.unknown) {
        errorMessage = "未知错误，请重试";
      }
      ToastUtils.showErrorMsg(errorMessage);
      debugPrint(errorMessage);
    }

    handler.next(err); // 确保错误继续传递
  }
}
