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
        final size = MediaQuery.sizeOf(context);

        final sizingInformation = SizingInformation(
          deviceScreenType: getDeviceType(size, breakpoints),
          refinedSize: getRefinedSize(
            size,
            refinedBreakpoint: refinedBreakpoints,
          ),
          screenSize: size,
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
