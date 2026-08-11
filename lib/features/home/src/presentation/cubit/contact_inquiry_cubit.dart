import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact_inquiry.dart';
import '../../domain/usecases/send_contact_inquiry.dart';
import 'contact_inquiry_state.dart';

final class ContactInquiryCubit extends Cubit<ContactInquiryState> {
  static const String successMessage =
      'Strategic inquiry submitted successfully!';
  static const String failureMessage =
      'Failed to transmit inquiry. Please try again.';

  final SendContactInquiry sendContactInquiry;

  ContactInquiryCubit({required this.sendContactInquiry})
    : super(const ContactInquiryState());

  Future<void> submitInquiry(ContactInquiry inquiry) async {
    try {
      await _trySubmitInquiry(inquiry);
    } catch (_) {
      _reportSubmissionFailed();
    }
  }

  Future<void> _trySubmitInquiry(ContactInquiry inquiry) async {
    emit(state.copyWith(status: ContactInquiryStatus.submitting));

    (await sendContactInquiry(inquiry))
        ? _reportSubmissionDone()
        : _reportSubmissionFailed();
  }

  void _reportSubmissionDone() {
    emit(
      state.copyWith(
        status: ContactInquiryStatus.success,
        message: successMessage,
      ),
    );
  }

  void _reportSubmissionFailed() {
    emit(
      state.copyWith(
        status: ContactInquiryStatus.failure,
        message: failureMessage,
      ),
    );
  }
}
