import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/home/src/domain/entities/contact_inquiry.dart';
import 'package:portfolio/features/home/src/domain/usecases/send_contact_inquiry.dart';
import 'contact_inquiry_state.dart';

final class ContactInquiryCubit extends Cubit<ContactInquiryState> {
  final SendContactInquiry sendContactInquiry;

  ContactInquiryCubit({
    required this.sendContactInquiry,
  }) : super(const ContactInquiryState());

  Future<void> submitInquiry(ContactInquiry inquiry) async {
    emit(state.copyWith(status: ContactInquiryStatus.submitting));
    try {
      final success = await sendContactInquiry(inquiry);
      if (success) {
        emit(
          state.copyWith(
            status: ContactInquiryStatus.success,
            message: 'Strategic inquiry submitted successfully!',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ContactInquiryStatus.failure,
            message: 'Please provide valid inquiry details.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ContactInquiryStatus.failure,
          message: 'Failed to transmit inquiry. Please try again.',
        ),
      );
    }
  }
}
