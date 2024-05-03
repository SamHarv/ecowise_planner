class Client {
  final String clientID;
  final String companyID;
  final String projectID;
  final List<String> clientName;
  final List<String> clientEmail;
  final List<String> clientPhone;

  Client({
    required this.clientID,
    required this.companyID,
    required this.projectID,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
  });
}
