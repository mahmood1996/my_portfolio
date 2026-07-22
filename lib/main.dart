import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_system/theme/app_theme.dart';
import 'data/datasources/portfolio_local_data_source.dart';
import 'data/repositories/portfolio_repository_impl.dart';
import 'domain/usecases/get_portfolio_data.dart';
import 'domain/usecases/send_contact_inquiry.dart';
import 'presentation/bloc/portfolio_bloc.dart';
import 'presentation/pages/portfolio_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GoogleFonts.pendingFonts([
    GoogleFonts.inter(),
    GoogleFonts.spaceGrotesk(),
    GoogleFonts.plusJakartaSans(),
  ]);

  runApp(const PortfolioApp());
}

final class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Clean Architecture Dependency Graph
    final localDataSource = PortfolioLocalDataSourceImpl();
    final repository = PortfolioRepositoryImpl(
      localDataSource: localDataSource,
    );
    final getPortfolioData = GetPortfolioData(repository);
    final sendContactInquiry = SendContactInquiry(repository);

    return MaterialApp(
      title: 'Mahmood Abdelrazek Ali',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocProvider<PortfolioBloc>(
        create: (context) => PortfolioBloc(
          getPortfolioData: getPortfolioData,
          sendContactInquiry: sendContactInquiry,
        ),
        child: const PortfolioHomePage(),
      ),
    );
  }
}
