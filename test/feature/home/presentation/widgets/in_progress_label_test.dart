import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/l10n/app_localizations.dart';
import 'package:portfolio/features/home/src/presentation/widgets/projects_section/in_progress_label.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: InProgressLabel(),
      ),
    );
  }

  testWidgets(
    'renders In Progress label in italic and bold font style',
    (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final textFinder = find.text('In Progress');
      expect(textFinder, findsOneWidget);

      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.style?.fontStyle, FontStyle.italic);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    },
  );
}
