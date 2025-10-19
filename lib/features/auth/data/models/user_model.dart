import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.username,
    required super.isAuthenticated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      isAuthenticated: json['is_authenticated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'is_authenticated': isAuthenticated,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      username: user.username,
      isAuthenticated: user.isAuthenticated,
    );
  }
}
