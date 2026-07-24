import '../../domain/entities/skill_entity.dart';

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.title,
    required super.iconName,
    super.isSecondaryColor,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      title: json['title'] ?? '',
      iconName: json['iconName'] ?? '',
      isSecondaryColor: json['isSecondaryColor'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'iconName': iconName,
      'isSecondaryColor': isSecondaryColor,
    };
  }
}
