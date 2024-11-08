class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'password': password};

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'], email: json['email'], password: json['password']);
  }
}
