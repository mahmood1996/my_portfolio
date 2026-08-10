import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

final class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<PortfolioData> getPortfolioData() async {
    final about = await localDataSource.getAbout();
    final contact = await localDataSource.getContactInfo();
    final experiences = await localDataSource.getExperiences();
    final projects = await localDataSource.getProjects();
    final skills = await localDataSource.getSkills();
    final readings = await localDataSource.getReadings();

    return PortfolioData(
      about: about,
      contact: contact,
      experiences: experiences,
      projects: projects,
      skills: skills,
      readings: readings,
    );
  }
}

