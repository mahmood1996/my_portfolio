import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/l10n/app_localizations.dart';
import '../../../../../../design_system/theme/app_colors.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../cubit/download_cv_cubit.dart';
import '../../cubit/download_cv_state.dart';

final class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DownloadCVCubit, DownloadCVState>(
      builder: (context, downloadState) {
        final isDownloading =
            downloadState.status == DownloadCVStatus.inProgress;

        return ElevatedButton(
          onPressed: isDownloading
              ? null
              : () {
                  final cvUrl = context
                          .read<PortfolioBloc>()
                          .state
                          .data
                          ?.about
                          .cvUrl ??
                      '';
                  context.read<DownloadCVCubit>().downloadCV(cvUrl);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: isDownloading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.onPrimary,
                  ),
                )
              : Text(
                  l10n.downloadCv,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
        );
      },
    );
  }
}
