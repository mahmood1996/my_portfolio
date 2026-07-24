import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'sliver_responsive_builder.dart';

final class SliverResponsiveSection extends StatelessWidget {
  final Widget sliver;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final double verticalPadding;
  final double maxWidth;

  const SliverResponsiveSection({
    super.key,
    required this.sliver,
    this.backgroundColor,
    this.decoration,
    this.verticalPadding = 96.0,
    this.maxWidth = 1200.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverResponsiveBuilder(
      builder: (context, sizingInformation) {
        final paddingHorizontal = getValueForScreenType<double>(
          context: context,
          mobile: 20.0,
          tablet: 32.0,
          desktop: 64.0,
        );

        return DecoratedSliver(
          decoration:
              decoration?.copyWith(color: backgroundColor) ??
              BoxDecoration(color: backgroundColor),
          sliver: SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: paddingHorizontal,
              vertical: verticalPadding,
            ),

            sliver: sliver,
          ),
        );
      },
    );
  }
}
