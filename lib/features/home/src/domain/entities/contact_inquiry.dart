import 'package:equatable/equatable.dart';

class ContactInquiry extends Equatable {
  final String fullName;
  final String corporateEmail;
  final String projectSummary;

  const ContactInquiry({
    required this.fullName,
    required this.corporateEmail,
    required this.projectSummary,
  });

  @override
  List<Object?> get props => [fullName, corporateEmail, projectSummary];
}
