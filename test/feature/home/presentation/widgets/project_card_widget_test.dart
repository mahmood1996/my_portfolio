import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/l10n/app_localizations.dart';
import 'package:portfolio/features/home/src/domain/entities/project_entity.dart';
import 'package:portfolio/features/home/src/presentation/widgets/projects_section/in_progress_label.dart';
import 'package:portfolio/features/home/src/presentation/widgets/projects_section/project_card_widget.dart';
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

  const inProgressProject = ProjectEntity(
    category: 'HealthTech',
    title: 'Future Lab',
    description: 'Medical test app',
    iconName: 'insights',
    coverImage: '',
    appStoreUrl: '',
    googlePlayUrl: '',
  );

  Widget createWidgetUnderTest(ProjectEntity project) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: ProjectCardWidget(
          project: project,
          icon: Icons.insights,
        ),
      ),
    );
  }

  testWidgets(
    'renders InProgressLabel when project is not in production',
    (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(inProgressProject));
      await tester.pumpAndSettle();

      expect(find.byType(InProgressLabel), findsOneWidget);
      expect(find.byType(StoresButtons), findsNothing);
      expect(find.text('In Progress'), findsOneWidget);
    },
  );

  testWidgets(
    'renders StoresButtons when project is in production',
    (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(inProductionProject));
      await tester.pumpAndSettle();

      expect(find.byType(StoresButtons), findsOneWidget);
      expect(find.byType(InProgressLabel), findsNothing);
      expect(find.text('App Store'), findsOneWidget);
      expect(find.text('Play Store'), findsOneWidget);
    },
  );
}
