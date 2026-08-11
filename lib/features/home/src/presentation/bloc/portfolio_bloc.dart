import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

final class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolioData getPortfolioData;

  PortfolioBloc({
    required this.getPortfolioData,
  }) : super(const PortfolioState()) {
    on<LoadPortfolioDataEvent>(_onLoadPortfolioData);
  }

  Future<void> _onLoadPortfolioData(
    LoadPortfolioDataEvent event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final data = await getPortfolioData();
      emit(state.copyWith(isLoading: false, data: data));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load portfolio data.',
        ),
      );
    }
  }
}

