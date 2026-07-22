import '../../domain/entities/reading_entity.dart';

class ReadingModel extends ReadingEntity {
  const ReadingModel({
    required super.title,
    required super.author,
    required super.imagePath,
  });

  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'imagePath': imagePath,
    };
  }
}
