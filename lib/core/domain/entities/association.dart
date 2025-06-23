class Association {
  final String id;
  final String name;
  final String managerName;
  final String managerEmail;
  final String emailAssociation;
  final bool verified;
  final List<String>? mobileMoneyNumbers;
  final String? profilePicture;
  final String description;
  final List<Map<String, dynamic>>? socialLinks;

  Association({
    required this.id,
    required this.name,
    required this.managerName,
    required this.managerEmail,
    required this.emailAssociation,
    required this.verified,
    this.mobileMoneyNumbers,
    this.profilePicture,
    required this.description,
    this.socialLinks,
  });
}
