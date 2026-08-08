import 'package:flutter/material.dart';
import '../../../../../../core/l10n/app_localizations.dart';

final class InProgressLabel extends StatelessWidget {
  const InProgressLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.inProgress,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
