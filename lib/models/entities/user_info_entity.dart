import 'package:todo_app/configs/app_configs.dart';

class UserInfoEntity {
  String? userId;
  String? userName;
  String? avatarPath;

  UserInfoEntity({this.userId, this.userName, this.avatarPath});

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) {
    return UserInfoEntity(
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
      avatarPath: json['avatar_path'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (avatarPath != null) 'avatar_path': avatarPath,
    };
  }

  String get avatarUrl => "${AppConfigs.avatarBaseUrl}/$avatarPath";
}
