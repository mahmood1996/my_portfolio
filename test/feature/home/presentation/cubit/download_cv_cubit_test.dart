import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/presentation/cubit/download_cv_cubit.dart';
import 'package:portfolio/features/home/src/presentation/cubit/download_cv_state.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  late DownloadCVCubit cubit;

  tearDown(() {
    cubit.close();
  });

  test('initial state should have status initial and null errorMessage', () {
    cubit = DownloadCVCubit();
    expect(
      cubit.state,
      const DownloadCVState(
        status: DownloadCVStatus.initial,
        errorMessage: null,
      ),
    );
  });

  test('downloadCV should emit failure when cvUrl is empty string', () async {
    cubit = DownloadCVCubit();

    expectLater(
      cubit.stream,
      emitsInOrder([
        const DownloadCVState(
          status: DownloadCVStatus.failure,
          errorMessage: 'CV link is not available.',
        ),
      ]),
    );

    await cubit.downloadCV('');
  });

  test('downloadCV should emit failure when cvUrl is only whitespace', () async {
    cubit = DownloadCVCubit();

    expectLater(
      cubit.stream,
      emitsInOrder([
        const DownloadCVState(
          status: DownloadCVStatus.failure,
          errorMessage: 'CV link is not available.',
        ),
      ]),
    );

    await cubit.downloadCV('   ');
  });

  test('downloadCV emits [inProgress, success] when URL can be launched', () async {
    bool launched = false;
    cubit = DownloadCVCubit(
      canLaunchUrlDelegate: (uri) async => true,
      launchUrlDelegate: (uri, {mode = LaunchMode.platformDefault}) async {
        launched = true;
        return true;
      },
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const DownloadCVState(
          status: DownloadCVStatus.inProgress,
          errorMessage: null,
        ),
        const DownloadCVState(
          status: DownloadCVStatus.success,
          errorMessage: null,
        ),
      ]),
    );

    await cubit.downloadCV('https://example.com/cv.pdf');
    expect(launched, isTrue);
  });

  test('downloadCV emits [inProgress, failure] when canLaunchUrl returns false', () async {
    cubit = DownloadCVCubit(
      canLaunchUrlDelegate: (uri) async => false,
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const DownloadCVState(
          status: DownloadCVStatus.inProgress,
          errorMessage: null,
        ),
        const DownloadCVState(
          status: DownloadCVStatus.failure,
          errorMessage: 'Could not open CV link.',
        ),
      ]),
    );

    await cubit.downloadCV('https://example.com/cv.pdf');
  });

  test('downloadCV emits [inProgress, failure] when launch throws exception', () async {
    cubit = DownloadCVCubit(
      canLaunchUrlDelegate: (uri) async => throw Exception('Platform error'),
    );

    expectLater(
      cubit.stream,
      emitsInOrder([
        const DownloadCVState(
          status: DownloadCVStatus.inProgress,
          errorMessage: null,
        ),
        isA<DownloadCVState>()
            .having((s) => s.status, 'status', DownloadCVStatus.failure)
            .having(
              (s) => s.errorMessage?.contains('Platform error'),
              'contains error message',
              true,
            ),
      ]),
    );

    await cubit.downloadCV('https://example.com/cv.pdf');
  });
}
