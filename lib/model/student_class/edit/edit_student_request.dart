class EditStudentClassRequest {
  final String id;
  String classNumber;

  EditStudentClassRequest({required this.id, required this.classNumber});

  factory EditStudentClassRequest.fromJson(Map<String, dynamic> json) {
    return EditStudentClassRequest(
      id: json['id'],
      classNumber: json['classNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'classNumber': classNumber};
  }
}
