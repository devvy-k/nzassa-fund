import 'package:crowfunding_project/core/data/models/author_model.dart';

enum UserType { person, association }

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
  final UserType userType;
  final List<String>? preferredCategories;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.profilePicture,
    this.preferredCategories,
  });

  AuthorModel toAuthor() =>
      AuthorModel(id: id, name: name, profilePicture: profilePicture ?? '');
}
