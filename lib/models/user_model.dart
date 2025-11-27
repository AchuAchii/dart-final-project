class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
