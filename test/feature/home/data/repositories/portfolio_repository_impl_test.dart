import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/data/datasources/portfolio_local_data_source.dart';
import 'package:portfolio/features/home/src/data/models/about_model.dart';
import 'package:portfolio/features/home/src/data/models/contact_info_model.dart';
import 'package:portfolio/features/home/src/data/models/experience_model.dart';
import 'package:portfolio/features/home/src/data/models/project_model.dart';
import 'package:portfolio/features/home/src/data/models/reading_model.dart';
import 'package:portfolio/features/home/src/data/models/skill_model.dart';
import 'package:portfolio/features/home/src/data/repositories/portfolio_repository_impl.dart';

class FakeLocalDataSource implements PortfolioLocalDataSource {
  @override
  Future<AboutModel> getAbout() async => const AboutModel(
        name: 'Mahmoud',
        tagline: 'Developer',
        headlinePart1: 'Building',
        headlinePart2: 'Apps',
        bio: 'Bio text',
        cvUrl: 'https://example.com/cv.pdf',
      );

  @override
  Future<ContactInfoModel> getContactInfo() async => const ContactInfoModel(
        email: 'mahmood.abdelrazek@outlook.com',
        phone: '(+20) 106 150 1137',
        location: 'Cairo, Egypt',
        linkedInUrl: 'https://linkedin.com',
        gitHubUrl: 'https://github.com',
        gitLabUrl: 'https://gitlab.com',
      );

  @override
  Future<List<ExperienceModel>> getExperiences() async => [];

  @override
  Future<List<ProjectModel>> getProjects() async => [];

  @override
  Future<List<ReadingModel>> getReadings() async => [];

  @override
  Future<List<SkillModel>> getSkills() async => [];
}

void main() {
  group('PortfolioRepositoryImpl getPortfolioData', () {
    test('returns aggregated PortfolioData from localDataSource', () async {
      final repo = PortfolioRepositoryImpl(
        localDataSource: FakeLocalDataSource(),
      );

      final data = await repo.getPortfolioData();

      expect(data.about.name, 'Mahmoud');
      expect(data.contact.email, 'mahmood.abdelrazek@outlook.com');
      expect(data.experiences, isEmpty);
      expect(data.projects, isEmpty);
      expect(data.readings, isEmpty);
      expect(data.skills, isEmpty);
    });
  });
}
