import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String category;
  final String title;
  final String description;
  final String iconName;
  final String appStoreUrl;
  final String googlePlayUrl;

  const ProjectEntity({
    required this.category,
    required this.title,
    required this.description,
    required this.iconName,
    required this.appStoreUrl,
    required this.googlePlayUrl,
  });

  @override
  List<Object?> get props => [category, title, description, iconName, appStoreUrl, googlePlayUrl];
}
