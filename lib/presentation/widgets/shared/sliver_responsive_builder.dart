import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

final class SliverResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
  )
  builder;

  final ScreenBreakpoints? breakpoints;
  final RefinedBreakpoints? refinedBreakpoints;

  const SliverResponsiveBuilder({
    super.key,
    required this.builder,
    this.breakpoints,
    this.refinedBreakpoints,
  });

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        var mediaQuery = MediaQuery.of(context);
        var sizingInformation = SizingInformation(
          deviceScreenType: getDeviceType(mediaQuery.size, breakpoints),
          refinedSize: getRefinedSize(
            mediaQuery.size,
            refinedBreakpoint: refinedBreakpoints,
          ),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(
            constraints.crossAxisExtent,
            constraints.viewportMainAxisExtent,
          ),
        );
        return builder(context, sizingInformation);
      },
    );
  }
}
