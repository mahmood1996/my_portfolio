import 'package:equatable/equatable.dart';
import '../../domain/repositories/portfolio_repository.dart';

enum InquiryStatus { initial, submitting, success, failure }

class PortfolioState extends Equatable {
  final bool isLoading;
  final PortfolioData? data;
  final String? errorMessage;
  final InquiryStatus inquiryStatus;
  final String? inquiryMessage;
  final String? toastNotification;

  const PortfolioState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
    this.inquiryStatus = InquiryStatus.initial,
    this.inquiryMessage,
    this.toastNotification,
  });

  PortfolioState copyWith({
    bool? isLoading,
    PortfolioData? data,
    String? errorMessage,
    InquiryStatus? inquiryStatus,
    String? inquiryMessage,
    String? toastNotification,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      inquiryStatus: inquiryStatus ?? this.inquiryStatus,
      inquiryMessage: inquiryMessage ?? this.inquiryMessage,
      toastNotification: toastNotification,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        data,
        errorMessage,
        inquiryStatus,
        inquiryMessage,
        toastNotification,
      ];
}
