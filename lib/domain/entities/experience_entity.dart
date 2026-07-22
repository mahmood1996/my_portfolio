import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String period;
  final String title;
  final String description;
  final String iconName;
  final bool isHighlight;

  const ExperienceEntity({
    required this.period,
    required this.title,
    required this.description,
    required this.iconName,
    this.isHighlight = false,
  });

  @override
  List<Object?> get props => [period, title, description, iconName, isHighlight];
}
