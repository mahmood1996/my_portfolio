import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:portfolio/domain/entities/contact_inquiry.dart';
import 'package:portfolio/domain/usecases/get_portfolio_data.dart';
import 'package:portfolio/domain/usecases/send_contact_inquiry.dart';
import 'package:portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:portfolio/presentation/bloc/portfolio_event.dart';
import 'package:portfolio/presentation/bloc/portfolio_state.dart';

void main() {
  late PortfolioBloc portfolioBloc;
  late GetPortfolioData getPortfolioData;
  late SendContactInquiry sendContactInquiry;
  late PortfolioRepositoryImpl repository;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    final dataSource = PortfolioLocalDataSourceImpl();
    repository = PortfolioRepositoryImpl(localDataSource: dataSource);
    getPortfolioData = GetPortfolioData(repository);
    sendContactInquiry = SendContactInquiry(repository);

    portfolioBloc = PortfolioBloc(
      getPortfolioData: getPortfolioData,
      sendContactInquiry: sendContactInquiry,
    );
  });

  tearDown(() {
    portfolioBloc.close();
  });

  test('initial state should be empty PortfolioState', () {
    expect(portfolioBloc.state, const PortfolioState());
  });

  test(
    'LoadPortfolioDataEvent should load experiences, projects, skills, and readings',
    () async {
      portfolioBloc.add(LoadPortfolioDataEvent());

      await expectLater(
        portfolioBloc.stream,
        emitsInOrder([
          const PortfolioState(isLoading: true),
          isA<PortfolioState>()
              .having((s) => s.isLoading, 'isLoading', false)
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

  test('SubmitContactInquiryEvent should process strategic inquiry', () async {
    const inquiry = ContactInquiry(
      fullName: 'Jane Developer',
      corporateEmail: 'jane@enterprise.com',
      projectSummary: 'Need architectural overhaul.',
    );

    portfolioBloc.add(const SubmitContactInquiryEvent(inquiry));

    await expectLater(
      portfolioBloc.stream,
      emitsInOrder([
        const PortfolioState(inquiryStatus: InquiryStatus.submitting),
        isA<PortfolioState>()
            .having(
              (s) => s.inquiryStatus,
              'inquiryStatus',
              InquiryStatus.success,
            )
            .having(
              (s) => s.inquiryMessage,
              'inquiryMessage',
              'Strategic inquiry submitted successfully!',
            ),
      ]),
    );
  });
}
