import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.category,
    required super.title,
    required super.description,
    required super.iconName,
    required super.appStoreUrl,
    required super.googlePlayUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      iconName: json['iconName'] ?? '',
      appStoreUrl: json['appStoreUrl'] ?? '',
      googlePlayUrl: json['googlePlayUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'title': title,
      'description': description,
      'iconName': iconName,
      'appStoreUrl': appStoreUrl,
      'googlePlayUrl': googlePlayUrl,
    };
  }
}
