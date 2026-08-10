import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/data/datasources/portfolio_local_data_source.dart';
import 'package:portfolio/features/home/src/data/repositories/portfolio_repository_impl.dart';
import 'package:portfolio/features/home/src/domain/usecases/get_portfolio_data.dart';
import 'package:portfolio/features/home/src/presentation/bloc/portfolio_bloc.dart';
import 'package:portfolio/features/home/src/presentation/bloc/portfolio_event.dart';
import 'package:portfolio/features/home/src/presentation/bloc/portfolio_state.dart';

void main() {
  late PortfolioBloc portfolioBloc;
  late GetPortfolioData getPortfolioData;
  late PortfolioRepositoryImpl repository;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    final dataSource = PortfolioLocalDataSourceImpl();
    repository = PortfolioRepositoryImpl(
      localDataSource: dataSource,
    );
    getPortfolioData = GetPortfolioData(repository);

    portfolioBloc = PortfolioBloc(
      getPortfolioData: getPortfolioData,
    );
  });

  tearDown(() {
    portfolioBloc.close();
  });

  test('initial state should be empty PortfolioState', () {
    expect(portfolioBloc.state, const PortfolioState());
  });

  test(
    'LoadPortfolioDataEvent should load about, contact, experiences, projects, skills, and readings',
    () async {
      portfolioBloc.add(LoadPortfolioDataEvent());

      await expectLater(
        portfolioBloc.stream,
        emitsInOrder([
          const PortfolioState(isLoading: true),
          isA<PortfolioState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having(
                (s) => s.data?.about.name.isNotEmpty,
                'about.name is Not Empty',
                true,
              )
              .having(
                (s) => s.data?.about.cvUrl.isNotEmpty,
                'about.cvUrl is Not Empty',
                true,
              )
              .having(
                (s) => s.data?.contact.email.isNotEmpty,
                'contact.email is Not Empty',
                true,
              )
              .having(
                (s) => s.data?.experiences.isNotEmpty,
                'experiences is Not Empty',
                true,
              )
              .having(
                (s) => s.data?.projects.isNotEmpty,
                'projects is Not Empty',
                true,
              )
              .having(
                (s) => s.data?.skills.isNotEmpty,
                'skills is Not Empty',
                true,
              )
              .having(
                (s) => s.data?.readings.isNotEmpty,
                'readings is Not Empty',
                true,
              ),
        ]),
      );
    },
  );
}

