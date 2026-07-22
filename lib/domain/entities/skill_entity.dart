import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String title;
  final String iconName;
  final bool isSecondaryColor;

  const SkillEntity({
    required this.title,
    required this.iconName,
    this.isSecondaryColor = false,
  });

  @override
  List<Object?> get props => [title, iconName, isSecondaryColor];
}
