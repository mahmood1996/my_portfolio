import 'package:equatable/equatable.dart';

enum ContactInquiryStatus { initial, submitting, success, failure }

final class ContactInquiryState extends Equatable {
  final ContactInquiryStatus status;
  final String? message;

  const ContactInquiryState({
    this.status = ContactInquiryStatus.initial,
    this.message,
  });

  ContactInquiryState copyWith({
    ContactInquiryStatus? status,
    String? message,
  }) {
    return ContactInquiryState(
      status: status ?? this.status,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
