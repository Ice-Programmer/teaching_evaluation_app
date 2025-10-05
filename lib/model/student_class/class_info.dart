class ClassInfo {
  String id;
  String classNumber;
  int createAt;

  ClassInfo({
    required this.id,
    required this.classNumber,
    required this.createAt,
  });

  /// 从 JSON 转成对象
  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      id: json['id'],
      classNumber: json['classNumber'],
      createAt: json['createAt'],
    );
  }

  /// 转成 JSON，用于请求体或存储
  Map<String, dynamic> toJson() {
    return {'id': id, 'classNumber': classNumber, 'createAt': createAt};
  }
}
