class DeleteStudentClassRequest {
  final String id;

  DeleteStudentClassRequest({required this.id});

  factory DeleteStudentClassRequest.fromJson(Map<String, dynamic> json) {
    return DeleteStudentClassRequest(id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
