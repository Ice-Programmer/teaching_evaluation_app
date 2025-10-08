class CreateStudentClassRequest {
  String? classNumber;

  CreateStudentClassRequest({this.classNumber});

  factory CreateStudentClassRequest.fromJson(Map<String, dynamic> json) {
    return CreateStudentClassRequest(
      classNumber: json['classNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'classNumber': classNumber};
  }
}
