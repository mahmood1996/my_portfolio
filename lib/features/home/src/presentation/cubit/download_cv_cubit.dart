import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'download_cv_state.dart';

typedef CanLaunchUrlDelegate = Future<bool> Function(Uri uri);
typedef LaunchUrlDelegate = Future<bool> Function(Uri uri, {LaunchMode mode});

final class DownloadCVCubit extends Cubit<DownloadCVState> {
  final CanLaunchUrlDelegate _canLaunchUrl;
  final LaunchUrlDelegate _launchUrl;

  DownloadCVCubit({
    CanLaunchUrlDelegate? canLaunchUrlDelegate,
    LaunchUrlDelegate? launchUrlDelegate,
  }) : _canLaunchUrl = canLaunchUrlDelegate ?? canLaunchUrl,
       _launchUrl = launchUrlDelegate ?? launchUrl,
       super(const DownloadCVState());

  Future<void> downloadCV(String cvUrl) async {
    if (cvUrl.trim().isEmpty) {
      return emit(
        state.copyWith(
          status: DownloadCVStatus.failure,
          errorMessage: 'CV link is not available.',
        ),
      );
    }

    emit(
      state.copyWith(status: DownloadCVStatus.inProgress, errorMessage: null),
    );

    try {
      final uri = Uri.parse(cvUrl.trim());
      final canLaunch = await _canLaunchUrl(uri);

      if (canLaunch) {
        await _launchUrl(uri, mode: LaunchMode.platformDefault);
        emit(state.copyWith(status: DownloadCVStatus.success));
      } else {
        emit(
          state.copyWith(
            status: DownloadCVStatus.failure,
            errorMessage: 'Could not open CV link.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: DownloadCVStatus.failure,
          errorMessage: 'Failed to open CV: $e',
        ),
      );
    }
  }
}
