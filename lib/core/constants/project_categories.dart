enum ProjectCategories {
  sante,
  desastres,
  education,
  charite,
  communaute,
  sport,
}

extension ProjectCategoriesExtension on ProjectCategories {
  String get label {
    switch (this) {
      case ProjectCategories.sante:
        return 'Santé';
      case ProjectCategories.desastres:
        return 'Désastres';
      case ProjectCategories.education:
        return 'Éducation';
      case ProjectCategories.charite:
        return 'Charité';
      case ProjectCategories.communaute:
        return 'Communauté';
      case ProjectCategories.sport:
        return 'Sport';
    }
  }
}