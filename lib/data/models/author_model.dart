import 'package:crowfunding_project/domain/entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel({
    required super.id,
    required super.name,
    required super.profilePicture,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] ?? '', // ou json['id'] ?? UniqueKey().toString()
      name: json['name'] ?? 'Utilisateur inconnu',
      profilePicture: json['profilePicture'] ?? '', // ou une image par défaut
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
    };
  }
}
