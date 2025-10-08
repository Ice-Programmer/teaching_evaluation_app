import 'package:flutter/material.dart';
import 'package:teaching_evaluation_app/consts/page_const.dart';
import 'package:teaching_evaluation_app/model/student_class/class_info.dart';
import 'package:teaching_evaluation_app/model/student_class/query/query_student_class_request.dart';
import 'package:teaching_evaluation_app/service/class_service.dart';

class ClassDataViewModel extends ChangeNotifier {
  final ClassService _classService = ClassService();

  List<ClassInfo> _classInfoList = [];
  List<ClassInfo> get classInfoList => _classInfoList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _currentPageNum = PageConst.defaultPageNum;
  int get currentPageNum => _currentPageNum;

  int _currentPageSize = PageConst.defaultPageSize;
  int get currentPageSize => _currentPageSize;

  int _total = 0;
  int get total => _total;

  final QueryStudentClassRequest _queryStudentClassRequest =
      QueryStudentClassRequest(
        pageNum: PageConst.defaultPageNum,
        pageSize: PageConst.defaultPageSize,
      );

  /// 获取课程列表（当前页）
  Future<void> fetchClassInfoList() async {
    _isLoading = true;
    notifyListeners();
    try {
      _queryStudentClassRequest.pageNum = _currentPageNum;
      _queryStudentClassRequest.pageSize = _currentPageSize;

      final response = await _classService.queryStudentClassList(
        _queryStudentClassRequest,
      );

      _classInfoList = response.classList;
      _total = response.total;
    } catch (e) {
      debugPrint('加载课程列表失败: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 跳转到指定页
  Future<void> goToPage(int pageNum) async {
    if (pageNum < 1) return;
    _currentPageNum = pageNum;
    await fetchClassInfoList();
  }

  /// 修改每页大小
  Future<void> changePageSize(int pageSize) async {
    _currentPageSize = pageSize;
    _currentPageNum = 1; // 回到第一页
    await fetchClassInfoList();
  }

  /// 刷新当前页
  Future<void> refresh() async {
    await fetchClassInfoList();
  }
}
