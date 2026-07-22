import 'package:equatable/equatable.dart';

class ReadingEntity extends Equatable {
  final String title;
  final String author;
  final String imagePath;

  const ReadingEntity({
    required this.title,
    required this.author,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [title, author, imagePath];
}
