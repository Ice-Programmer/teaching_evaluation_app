import 'package:teaching_evaluation_app/consts/page_const.dart';

class QueryStudentClassRequest {
  QueryClassCondition? condition;
  int pageNum;
  int pageSize;

  QueryStudentClassRequest({
    this.condition,
    required this.pageNum,
    required this.pageSize,
  });

  factory QueryStudentClassRequest.fromJson(Map<String, dynamic> json) {
    return QueryStudentClassRequest(
      condition:
          json['condition'] != null
              ? QueryClassCondition.fromJson(json['condition'])
              : null,
      pageNum: json['pageNum'] ?? PageConst.defaultPageNum,
      pageSize: json['pageSize'] ?? PageConst.defaultPageSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (condition != null) 'condition': condition!.toJson(),
      'pageNum': pageNum,
      'pageSize': pageSize,
    };
  }
}

class QueryClassCondition {
  int? id;
  String? classNumber;
  List<int>? ids;

  QueryClassCondition({this.id, this.classNumber, this.ids});

  factory QueryClassCondition.fromJson(Map<String, dynamic> json) {
    return QueryClassCondition(
      id: json['id'],
      classNumber: json['classNumber'],
      ids: json['ids'] != null ? List<int>.from(json['ids']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classNumber != null) 'classNumber': classNumber,
      if (ids != null) 'ids': ids,
    };
  }
}
