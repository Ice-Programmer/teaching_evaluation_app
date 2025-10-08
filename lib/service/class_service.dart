import 'package:dio/dio.dart';
import 'package:teaching_evaluation_app/http/business_exception.dart';
import 'package:teaching_evaluation_app/http/dio_instance.dart';
import 'package:teaching_evaluation_app/http/http_constant.dart';
import 'package:teaching_evaluation_app/model/student_class/create/create_student_class_request.dart';
import 'package:teaching_evaluation_app/model/student_class/delete/delete_student_class_request.dart';
import 'package:teaching_evaluation_app/model/student_class/edit/edit_student_class_request.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_request.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_response.dart';
import 'package:teaching_evaluation_app/utils/toast_util.dart';

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
        ToastUtils.showErrorMsg(
          '获取课程列表失败: ${baseResponse.baseResp.statusMessage}',
        );
        // 抛出业务异常
        throw BusinessException(
          '获取课程列表失败: ${baseResponse.baseResp.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<bool> editStudentClass(EditStudentClassRequest request) async {
    try {
      final response = await _dioInstance.post(
        path: 'admin/student/class/edit',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );

      final baseResponse = QueryStudentClassResponse.fromJson(response.data);

      if (baseResponse.baseResp.statusCode == HttpConstant.successCode) {
        return true;
      } else {
        ToastUtils.showErrorMsg(
          '更新课程失败: ${baseResponse.baseResp.statusMessage}',
        );
      }
      return false;
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<bool> deleteStudentClass(DeleteStudentClassRequest request) async {
    try {
      final response = await _dioInstance.post(
        path: 'admin/student/class/delete',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );

      final baseResponse = QueryStudentClassResponse.fromJson(response.data);

      if (baseResponse.baseResp.statusCode == HttpConstant.successCode) {
        return true;
      } else {
        ToastUtils.showErrorMsg(
          '删除课程失败: ${baseResponse.baseResp.statusMessage}',
        );
      }
      return false;
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<bool> createStudentClass(CreateStudentClassRequest request) async {
    try {
      final response = await _dioInstance.post(
        path: 'admin/student/class/create',
        data: request.toJson(),
        options: Options(contentType: 'application/json'),
      );

      final baseResponse = QueryStudentClassResponse.fromJson(response.data);

      if (baseResponse.baseResp.statusCode == HttpConstant.successCode) {
        return true;
      } else {
        ToastUtils.showErrorMsg(
          '创建课程失败: ${baseResponse.baseResp.statusMessage}',
        );
      }
      return false;
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
