import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/l10n/app_localizations.dart';
import '../../../../../../design_system/asset_paths/app_assets.dart';
import '../../../domain/entities/project_entity.dart';
import 'store_button_widget.dart';

final class StoresButtons extends StatelessWidget {
  const StoresButtons({super.key, required this._project});

  final ProjectEntity _project;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (_project.appStoreUrl.isNotEmpty)
          StoreButtonWidget(
            label: l10n.appStore,
            iconAsset: AppAssets.appStore,
            onTap: () => _launch(_project.appStoreUrl),
          ),

        if (_project.googlePlayUrl.isNotEmpty)
          StoreButtonWidget(
            label: l10n.playStore,
            iconAsset: AppAssets.googlePlay,
            onTap: () => _launch(_project.googlePlayUrl),
          ),
      ],
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
