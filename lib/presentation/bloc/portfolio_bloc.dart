import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import '../../domain/usecases/send_contact_inquiry.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolioData getPortfolioData;
  final SendContactInquiry sendContactInquiry;

  PortfolioBloc({
    required this.getPortfolioData,
    required this.sendContactInquiry,
  }) : super(const PortfolioState()) {
    on<LoadPortfolioDataEvent>(_onLoadPortfolioData);
    on<SubmitContactInquiryEvent>(_onSubmitContactInquiry);
    on<DownloadCVEvent>(_onDownloadCV);
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
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load portfolio data.',
      ));
    }
  }

  Future<void> _onSubmitContactInquiry(
    SubmitContactInquiryEvent event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(state.copyWith(inquiryStatus: InquiryStatus.submitting));
    try {
      final success = await sendContactInquiry(event.inquiry);
      if (success) {
        emit(state.copyWith(
          inquiryStatus: InquiryStatus.success,
          inquiryMessage: 'Strategic inquiry submitted successfully!',
          toastNotification: 'Inquiry received. We will get back to you shortly.',
        ));
      } else {
        emit(state.copyWith(
          inquiryStatus: InquiryStatus.failure,
          inquiryMessage: 'Please provide valid inquiry details.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        inquiryStatus: InquiryStatus.failure,
        inquiryMessage: 'Failed to transmit inquiry. Please try again.',
      ));
    }
  }

  void _onDownloadCV(
    DownloadCVEvent event,
    Emitter<PortfolioState> emit,
  ) {
    emit(state.copyWith(
      toastNotification: 'Downloading Senior Architect CV...',
    ));
  }
}
