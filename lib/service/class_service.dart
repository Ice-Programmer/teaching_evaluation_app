import 'package:dio/dio.dart';
import 'package:teaching_evaluation_app/http/business_exception.dart';
import 'package:teaching_evaluation_app/http/dio_instance.dart';
import 'package:teaching_evaluation_app/http/http_constant.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_request.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_response.dart';

class ClassService {
  final DioInstance _dioInstance = DioInstance.instance();

  Future<QueryStudentClassResponse> queryStudentClassList(
    QueryStudentClassRequest request,
  ) async {
    try {
      final response = await _dioInstance.post(
        path: 'admin/student/class/query',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );

      final baseResponse = QueryStudentClassResponse.fromJson(response.data);

      if (baseResponse.baseResp.statusCode == HttpConstant.successCode) {
        return baseResponse;
      } else {
        // 抛出业务异常
        throw BusinessException(
          '获取课程列表失败: ${baseResponse.baseResp.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
