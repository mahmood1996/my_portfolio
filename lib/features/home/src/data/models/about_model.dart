import '../../domain/entities/about_entity.dart';

class AboutModel extends AboutEntity {
  const AboutModel({
    required super.name,
    required super.tagline,
    required super.headlinePart1,
    required super.headlinePart2,
    required super.bio,
    super.cvUrl = '',
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      name: json['name'] ?? '',
      tagline: json['tagline'] ?? '',
      headlinePart1: json['headlinePart1'] ?? '',
      headlinePart2: json['headlinePart2'] ?? '',
      bio: json['bio'] ?? '',
      cvUrl: json['cvUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tagline': tagline,
      'headlinePart1': headlinePart1,
      'headlinePart2': headlinePart2,
      'bio': bio,
      'cvUrl': cvUrl,
    };
  }
}
