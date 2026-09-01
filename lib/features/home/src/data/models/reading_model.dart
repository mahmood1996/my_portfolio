import '../../domain/entities/reading_entity.dart';

class ReadingModel extends ReadingEntity {
  const ReadingModel({
    required super.title,
    required super.author,
    required super.imageUrl,
  });

  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      imageUrl: json['imageUrl'] ?? json['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'author': author, 'imageUrl': imageUrl};
  }
}
