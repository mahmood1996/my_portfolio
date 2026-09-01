import 'package:equatable/equatable.dart';

class ReadingEntity extends Equatable {
  final String title;
  final String author;
  final String imageUrl;

  const ReadingEntity({
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [title, author, imageUrl];
}
