import 'package:equatable/equatable.dart';
import 'package:portfolio/features/home/src/domain/repositories/portfolio_repository.dart';

class PortfolioState extends Equatable {
  final bool isLoading;
  final PortfolioData? data;
  final String? errorMessage;

  const PortfolioState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
  });

  PortfolioState copyWith({
    bool? isLoading,
    PortfolioData? data,
    String? errorMessage,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}

