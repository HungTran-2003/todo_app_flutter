import 'dart:typed_data';
import 'package:todo_app/models/entities/user_info_entity.dart';
import 'package:todo_app/networking/api_client.dart';

abstract class UserRepository {
  Future<UserInfoEntity> getUserInfo();

  Future<UserInfoEntity> updateUserInfo(UserInfoEntity userInfo);


  Future<String> uploadAvatar(Uint8List file, String fileName);

}

class UserRepositoryImpl extends UserRepository {
  final ApiClient _apiClient;

  UserRepositoryImpl(this._apiClient);

  @override
  Future<String> uploadAvatar(Uint8List file, String fileName) async {
    final path = await _apiClient.uploadAvatar(file, fileName);
    if (path.isEmpty) {
      throw Exception("Upload avatar failed");
    }
    return path;
  }

  @override
  Future<UserInfoEntity> getUserInfo() {
    return _apiClient.getUserInfo();
  }

  @override
  Future<UserInfoEntity> updateUserInfo(UserInfoEntity userInfo) {
    return _apiClient.updateUserInfo(userInfo);
  }
}
