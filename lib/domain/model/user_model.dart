class UserModel {
  final String userID;
  String companyID;
  final String firstName;
  final String surname;
  final String email;

  UserModel({
    required this.userID,
    required this.companyID,
    required this.firstName,
    required this.surname,
    required this.email,
  });

  @override
  String toString() {
    return 'UserModel{userID: $userID, companyID: $companyID, firstName: $firstName, surname: $surname, email: $email}';
  }
}
