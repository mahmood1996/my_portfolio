import 'package:equatable/equatable.dart';

class AboutEntity extends Equatable {
  final String name;
  final String tagline;
  final String headlinePart1;
  final String headlinePart2;
  final String bio;

  const AboutEntity({
    required this.name,
    required this.tagline,
    required this.headlinePart1,
    required this.headlinePart2,
    required this.bio,
  });

  @override
  List<Object?> get props => [name, tagline, headlinePart1, headlinePart2, bio];
}
