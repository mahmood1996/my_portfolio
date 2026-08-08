import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/l10n/app_localizations.dart';
import 'package:portfolio/features/home/src/domain/entities/project_entity.dart';
import 'package:portfolio/features/home/src/presentation/widgets/projects_section/stores_buttons.dart';

void main() {
  const inProductionProject = ProjectEntity(
    category: 'Commerce',
    title: 'Speed Delivery',
    description: 'Delivery app',
    iconName: 'insights',
    coverImage: '',
    appStoreUrl: 'https://apple.com',
    googlePlayUrl: 'https://google.com',
  );

  Widget createWidgetUnderTest(ProjectEntity project) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: StoresButtons(project: project),
      ),
    );
  }

  testWidgets('renders store buttons when project has store urls', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(inProductionProject));
    await tester.pumpAndSettle();

    expect(find.text('App Store'), findsOneWidget);
    expect(find.text('Play Store'), findsOneWidget);
  });
}
