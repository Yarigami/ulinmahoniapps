
class Register {
  final int id;
  final String username;
  final String email;
  final int status;
  final int isAdmin;
  final String profilePhotoUrl;
  final String token;

  Register({
    required this.id,
    required this.username,
    required this.email,
    required this.status,
    required this.isAdmin,
    required this.profilePhotoUrl,
    required this.token,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return Register(
      id: user['id'],
      username: user['username'],
      email: user['email'],
      status: user['status'],
      isAdmin: user['is_admin'],
      profilePhotoUrl: user['profile_photo_url'] ?? '',
      token: json['token'],
    );
  }
}
