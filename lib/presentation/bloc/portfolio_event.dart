import 'package:equatable/equatable.dart';
import '../../domain/entities/contact_inquiry.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object?> get props => [];
}

class LoadPortfolioDataEvent extends PortfolioEvent {}

class SubmitContactInquiryEvent extends PortfolioEvent {
  final ContactInquiry inquiry;

  const SubmitContactInquiryEvent(this.inquiry);

  @override
  List<Object?> get props => [inquiry];
}

class DownloadCVEvent extends PortfolioEvent {}
