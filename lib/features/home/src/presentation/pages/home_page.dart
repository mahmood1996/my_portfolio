import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/contact_access_key_data_source.dart';
import '../../data/datasources/contact_remote_data_source.dart';
import '../../data/datasources/portfolio_local_data_source.dart';
import '../../data/repositories/contact_inquiry_repository_impl.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import '../../domain/usecases/send_contact_inquiry.dart';

import '../bloc/portfolio_bloc.dart';
import '../cubit/contact_inquiry_cubit.dart';
import '../cubit/download_cv_cubit.dart';

import '../widgets/home_view.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioBloc>(
          create: (context) {
            final localDataSource = PortfolioLocalDataSourceImpl();
            final repository = PortfolioRepositoryImpl(
              localDataSource: localDataSource,
            );
            final getPortfolioData = GetPortfolioData(repository);

            return PortfolioBloc(
              getPortfolioData: getPortfolioData,
            );
          },
        ),
        BlocProvider<ContactInquiryCubit>(
          create: (context) {
            final accessKeyDataSource = ContactAccessKeyDataSourceImpl();
            final remoteDataSource = ContactRemoteDataSourceImpl();

            final repository = ContactInquiryRepositoryImpl(
              accessKeyDataSource: accessKeyDataSource,
              remoteDataSource: remoteDataSource,
            );

            final sendContactInquiry = SendContactInquiry(repository);

            return ContactInquiryCubit(
              sendContactInquiry: sendContactInquiry,
            );
          },
        ),
        BlocProvider<DownloadCVCubit>(
          create: (context) => DownloadCVCubit(),
        ),
      ],
      child: const HomeView(),
    );
  }
}


