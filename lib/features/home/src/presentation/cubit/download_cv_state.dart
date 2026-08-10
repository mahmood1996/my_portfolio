import 'package:equatable/equatable.dart';

enum DownloadCVStatus { initial, inProgress, success, failure }

final class DownloadCVState extends Equatable {
  final DownloadCVStatus status;
  final String? errorMessage;

  const DownloadCVState({
    this.status = DownloadCVStatus.initial,
    this.errorMessage,
  });

  DownloadCVState copyWith({
    DownloadCVStatus? status,
    String? errorMessage,
  }) {
    return DownloadCVState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
