import 'package:teaching_evaluation_app/http/base_response.dart';
import 'package:teaching_evaluation_app/model/student_class/class_info.dart';

class QueryStudentClassResponse {
  int total;
  List<ClassInfo> classList;
  BaseResp baseResp;

  QueryStudentClassResponse({
    required this.total,
    required this.classList,
    required this.baseResp,
  });

  factory QueryStudentClassResponse.fromJson(Map<String, dynamic> json) {
    return QueryStudentClassResponse(
      total: json['total'],
      classList:
          (json['classList'] as List<dynamic>?)
              ?.map((e) => ClassInfo.fromJson(e))
              .toList() ??
          [],
      baseResp: BaseResp.fromJson(json['BaseResp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'classList': classList.map((e) => e.toJson()).toList(),
      'BaseResp': baseResp.toJson(),
    };
  }
}
