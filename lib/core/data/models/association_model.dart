import 'package:crowfunding_project/core/domain/entities/association.dart';

class AssociationModel extends Association {
  AssociationModel({
    required super.id,
    required super.name,
    required super.managerName,
    required super.managerEmail,
    required super.emailAssociation,
    required super.verified,
    super.mobileMoneyNumbers,
    super.profilePicture,
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
      verified: json['verified'] as bool,
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
      'verified': verified,
      'mobileMoneyNumbers': mobileMoneyNumbers,
      'profilePicture': profilePicture,
      'description': description,
      'socialLinks': socialLinks,
    };
  }
  
  AssociationModel copyWith({
    String? id,
    String? name,
    String? managerName,
    String? managerEmail,
    String? emailAssociation,
    bool? verified,
    List<String>? mobileMoneyNumbers,
    String? profilePicture,
    String? description,
    List<Map<String, dynamic>>? socialLinks,
  }) {
    return AssociationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      managerName: managerName ?? this.managerName,
      managerEmail: managerEmail ?? this.managerEmail,
      emailAssociation: emailAssociation ?? this.emailAssociation,
      verified: verified ?? this.verified,
      mobileMoneyNumbers: mobileMoneyNumbers ?? this.mobileMoneyNumbers,
      profilePicture: profilePicture ?? this.profilePicture,
      description: description ?? this.description,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }

}