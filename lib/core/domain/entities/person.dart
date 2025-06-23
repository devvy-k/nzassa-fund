class Person {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<String>? preferredCategories;
  final String? profilePicture;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.preferredCategories,
    this.profilePicture,
  });
}
