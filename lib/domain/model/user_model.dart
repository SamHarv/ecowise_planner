class User {
  final String userID;
  final String firstName;
  final String surname;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final String role;
  final String company;

  User({
    required this.userID,
    required this.firstName,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    this.profilePicture,
    required this.role,
    required this.company,
  });
}
