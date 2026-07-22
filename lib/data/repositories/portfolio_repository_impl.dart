import '../../domain/entities/contact_inquiry.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  PortfolioRepositoryImpl({required this.localDataSource});

  @override
  Future<PortfolioData> getPortfolioData() async {
    final experiences = await localDataSource.getExperiences();
    final projects = await localDataSource.getProjects();
    final skills = await localDataSource.getSkills();
    final readings = await localDataSource.getReadings();

    return PortfolioData(
      experiences: experiences,
      projects: projects,
      skills: skills,
      readings: readings,
    );
  }

  @override
  Future<bool> sendContactInquiry(ContactInquiry inquiry) async {
    // Simulate network delay for sending strategic inquiry
    await Future.delayed(const Duration(seconds: 1));
    return inquiry.fullName.isNotEmpty && inquiry.corporateEmail.isNotEmpty;
  }
}
