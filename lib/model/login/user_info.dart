/// 用户角色枚举，直接带数值
enum UserRole {
  student(1),
  admin(2),
  unknown(-1);

  final int value;
  const UserRole(this.value);

  static UserRole fromInt(int? value) {
    return UserRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => UserRole.unknown,
    );
  }
}

/// 用户信息模型
class UserInfo {
  final int id;
  final String name;
  final UserRole role;
  final int createAt;

  UserInfo({
    required this.id,
    required this.name,
    required this.role,
    required this.createAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json['id'],
    name: json['name'],
    role: UserRole.fromInt(json['role']),
    createAt: json['createAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role.value,
    'createAt': createAt,
  };
}
