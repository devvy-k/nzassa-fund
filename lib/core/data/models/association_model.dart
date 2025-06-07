import 'package:crowfunding_project/core/domain/entities/association.dart';

class AssociationModel extends Association {
  AssociationModel({
    required super.id,
    required super.name,
    required super.managerName,
    required super.managerEmail,
    required super.emailAssociation,
    required super.registrationFile,
    required super.mobileMoneyNumbers,
    required super.profilePicture,
    required super.description,
    super.socialLinks,
  });

  factory AssociationModel.fromJson(Map<String, dynamic> json) {
    return AssociationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      managerName: json['managerName'] as String,
      managerEmail: json['managerEmail'] as String,
      emailAssociation: json['emailAssociation'] as String,
      registrationFile: json['registrationFile'] as String,
      mobileMoneyNumbers: List<String>.from(json['mobileMoneyNumbers']),
      profilePicture: json['profilePicture'] as String,
      description: json['description'] as String,
      socialLinks: (json['socialLinks'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'managerName': managerName,
      'managerEmail': managerEmail,
      'emailAssociation': emailAssociation,
      'registrationFile': registrationFile,
      'mobileMoneyNumbers': mobileMoneyNumbers,
      'profilePicture': profilePicture,
      'description': description,
      'socialLinks': socialLinks,
    };
  }
}