import '../entities/contact_inquiry.dart';
import '../repositories/portfolio_repository.dart';

class SendContactInquiry {
  final PortfolioRepository repository;

  SendContactInquiry(this.repository);

  Future<bool> call(ContactInquiry inquiry) {
    return repository.sendContactInquiry(inquiry);
  }
}
