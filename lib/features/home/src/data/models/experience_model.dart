import '../../domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.period,
    required super.title,
    required super.description,
    required super.iconName,
    super.isHighlight,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      period: json['period'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      iconName: json['iconName'] ?? '',
      isHighlight: json['isHighlight'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period,
      'title': title,
      'description': description,
      'iconName': iconName,
      'isHighlight': isHighlight,
    };
  }
}
