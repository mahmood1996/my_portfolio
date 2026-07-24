import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/portfolio_local_data_source.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import '../../domain/usecases/send_contact_inquiry.dart';

import '../bloc/portfolio_bloc.dart';

import '../widgets/home_view.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortfolioBloc>(
      create: (context) {
        final localDataSource = PortfolioLocalDataSourceImpl();

        final repository = PortfolioRepositoryImpl(
          localDataSource: localDataSource,
        );

        final getPortfolioData = GetPortfolioData(repository);

        final sendContactInquiry = SendContactInquiry(repository);

        return PortfolioBloc(
          getPortfolioData: getPortfolioData,
          sendContactInquiry: sendContactInquiry,
        );
      },
      child: const HomeView(),
    );
  }
}
