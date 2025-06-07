import 'package:crowfunding_project/core/domain/entities/person.dart';

class PersonModel extends Person {
  PersonModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}
