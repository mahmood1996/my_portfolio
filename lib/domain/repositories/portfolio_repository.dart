import '../entities/experience_entity.dart';
import '../entities/project_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/reading_entity.dart';
import '../entities/contact_inquiry.dart';

class PortfolioData {
  final List<ExperienceEntity> experiences;
  final List<ProjectEntity> projects;
  final List<SkillEntity> skills;
  final List<ReadingEntity> readings;

  const PortfolioData({
    required this.experiences,
    required this.projects,
    required this.skills,
    required this.readings,
  });
}

abstract class PortfolioRepository {
  Future<PortfolioData> getPortfolioData();
  Future<bool> sendContactInquiry(ContactInquiry inquiry);
}
