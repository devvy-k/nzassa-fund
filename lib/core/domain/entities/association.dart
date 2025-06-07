class Association {
  final String id;
  final String name;
  final String managerName;
  final String managerEmail;
  final String emailAssociation;
  final String registrationFile;
  final List<String> mobileMoneyNumbers;
  final String? profilePicture;
  final String description;
  final List<Map<String, dynamic>>? socialLinks;

  Association({
    required this.id,
    required this.name,
    required this.managerName,
    required this.managerEmail,
    required this.emailAssociation,
    required this.registrationFile,
    required this.mobileMoneyNumbers,
    required this.profilePicture,
    required this.description,
    this.socialLinks,
  });
}
