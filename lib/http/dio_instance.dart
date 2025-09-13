import 'package:dio/dio.dart';
import 'package:teaching_evaluation_app/http/http_constant.dart';
import 'package:teaching_evaluation_app/http/http_methods.dart';

import 'interceptor/print_log_interceptor.dart';
import 'interceptor/response_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance instance() {
    return _instance ??= DioInstance._();
  }

  final Dio _dio = Dio();
  final _defaultTimeout = const Duration(seconds: 30);

  void initDio({
    String httpMethod = HttpMethods.get,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: HttpConstant.baseUrl,
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: connectTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      responseType: responseType,
      contentType: contentType,
    );
    // 返回结果处理
    _dio.interceptors.add(ResponseInterceptor());
    _dio.interceptors.add(PrintLogInterceptor());
  }

  /// get方法，主要获取JSON数据
  /// [path] 请求路径
  Future<Response> get({
    required String service,
    required String path,
    Object? data,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get(
      path,
      queryParameters: param,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: HttpMethods.get,
            receiveTimeout: _defaultTimeout,
            sendTimeout: _defaultTimeout,
          ),
    );
  }

  /// post请求
  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(
      path,
      queryParameters: param,
      data: data,
      cancelToken: cancelToken,
      options: options ??
          Options(
            method: HttpMethods.post,
            receiveTimeout: _defaultTimeout,
            sendTimeout: _defaultTimeout,
          ),
    );
  }
}
