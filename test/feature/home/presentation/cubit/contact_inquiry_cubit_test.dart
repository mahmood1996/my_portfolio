import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/domain/entities/contact_inquiry.dart';
import 'package:portfolio/features/home/src/domain/repositories/contact_inquiry_repository.dart';
import 'package:portfolio/features/home/src/domain/usecases/send_contact_inquiry.dart';
import 'package:portfolio/features/home/src/presentation/cubit/contact_inquiry_cubit.dart';
import 'package:portfolio/features/home/src/presentation/cubit/contact_inquiry_state.dart';

class MockContactInquiryRepository implements ContactInquiryRepository {
  final Future<bool> Function(ContactInquiry inquiry)? onSendContactInquiry;

  MockContactInquiryRepository({this.onSendContactInquiry});

  @override
  Future<bool> sendContactInquiry(ContactInquiry inquiry) async {
    if (onSendContactInquiry != null) {
      return onSendContactInquiry!(inquiry);
    }
    return true;
  }
}

void main() {
  const tInquiry = ContactInquiry(
    fullName: 'Jane Developer',
    corporateEmail: 'jane@enterprise.com',
    projectSummary: 'Need architectural overhaul.',
  );

  group('ContactInquiryCubit', () {
    test('initial state has initial status and null message', () {
      final repository = MockContactInquiryRepository();
      final cubit = ContactInquiryCubit(
        sendContactInquiry: SendContactInquiry(repository),
      );

      expect(
        cubit.state,
        const ContactInquiryState(
          status: ContactInquiryStatus.initial,
          message: null,
        ),
      );

      cubit.close();
    });

    test(
      'submitInquiry emits [submitting, success] when SendContactInquiry returns true',
      () async {
        final repository = MockContactInquiryRepository(
          onSendContactInquiry: (_) async => true,
        );
        final cubit = ContactInquiryCubit(
          sendContactInquiry: SendContactInquiry(repository),
        );

        expectLater(
          cubit.stream,
          emitsInOrder([
            const ContactInquiryState(
              status: ContactInquiryStatus.submitting,
            ),
            const ContactInquiryState(
              status: ContactInquiryStatus.success,
              message: 'Strategic inquiry submitted successfully!',
            ),
          ]),
        );

        await cubit.submitInquiry(tInquiry);
        cubit.close();
      },
    );

    test(
      'submitInquiry emits [submitting, failure] when SendContactInquiry returns false',
      () async {
        final repository = MockContactInquiryRepository(
          onSendContactInquiry: (_) async => false,
        );
        final cubit = ContactInquiryCubit(
          sendContactInquiry: SendContactInquiry(repository),
        );

        expectLater(
          cubit.stream,
          emitsInOrder([
            const ContactInquiryState(
              status: ContactInquiryStatus.submitting,
            ),
            const ContactInquiryState(
              status: ContactInquiryStatus.failure,
              message: 'Please provide valid inquiry details.',
            ),
          ]),
        );

        await cubit.submitInquiry(tInquiry);
        cubit.close();
      },
    );

    test(
      'submitInquiry emits [submitting, failure] when SendContactInquiry throws exception',
      () async {
        final repository = MockContactInquiryRepository(
          onSendContactInquiry: (_) async => throw Exception('Network error'),
        );
        final cubit = ContactInquiryCubit(
          sendContactInquiry: SendContactInquiry(repository),
        );

        expectLater(
          cubit.stream,
          emitsInOrder([
            const ContactInquiryState(
              status: ContactInquiryStatus.submitting,
            ),
            const ContactInquiryState(
              status: ContactInquiryStatus.failure,
              message: 'Failed to transmit inquiry. Please try again.',
            ),
          ]),
        );

        await cubit.submitInquiry(tInquiry);
        cubit.close();
      },
    );
  });
}
