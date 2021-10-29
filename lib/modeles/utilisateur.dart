class Utilisateur {
  late String username;
  late String email;
  late String password;

  Utilisateur({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  String toString() =>
      'Utilisateur(username: $username, email: $email, password: $password)';

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
