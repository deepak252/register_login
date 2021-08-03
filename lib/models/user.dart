
class User{
  final String firstName;
  final String lastName;
  final String userName;  
  final String email;
  final String password;
  final String? nonce;

  User({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    this.nonce,

  });

}