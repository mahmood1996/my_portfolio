import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/home/src/presentation/widgets/projects_section/project_cover_image.dart';

void main() {
  Widget createWidgetUnderTest({required String url, bool isHovered = false}) {
    return MaterialApp(
      home: Scaffold(
        body: ProjectCoverImage(url: url, isHovered: isHovered),
      ),
    );
  }

  testWidgets('preserves Google Drive URL if size parameter is already present', (
    tester,
  ) async {
    const presetUrl =
        'https://lh3.googleusercontent.com/d/13gzsIUTKCr-cAw41oFegkFVuKrIo2XEs=s300';

    await tester.pumpWidget(createWidgetUnderTest(url: presetUrl));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final imageWidget = tester.widget<Image>(imageFinder);
    expect(
      (imageWidget.image as NetworkImage).url,
      'https://lh3.googleusercontent.com/d/13gzsIUTKCr-cAw41oFegkFVuKrIo2XEs=s300',
    );
  });
}
