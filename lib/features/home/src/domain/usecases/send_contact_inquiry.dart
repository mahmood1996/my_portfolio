import '../entities/contact_inquiry.dart';
import '../repositories/contact_inquiry_repository.dart';

class SendContactInquiry {
  final ContactInquiryRepository repository;

  SendContactInquiry(this.repository);

  Future<bool> call(ContactInquiry inquiry) {
    return repository.sendContactInquiry(inquiry);
  }
}

