import '../entities/contact_inquiry.dart';

abstract interface class ContactInquiryRepository {
  Future<bool> sendContactInquiry(ContactInquiry inquiry);
}
