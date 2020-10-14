class User {
  String id;
  String username;
  String email;
  String token;
  User({this.id, this.email, this.token, this.username});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      token: json['jwt'],
      username: json['username'],
    );
  }
}