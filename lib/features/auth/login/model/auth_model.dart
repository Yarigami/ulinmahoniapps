class User {
  final int id;
  final String username;
  final String email;
  final String? name;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    required this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      profilePhotoUrl: json['profile_photo_url'] ?? '',
    );
  }
}
