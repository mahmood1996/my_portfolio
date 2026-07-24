import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

final class ResponsiveSectionWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Decoration? decoration;
  final double verticalPadding;
  final double maxWidth;

  const ResponsiveSectionWidget({
    super.key,
    required this.child,
    this.backgroundColor,
    this.decoration,
    this.verticalPadding = 96.0,
    this.maxWidth = 1200.0,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final paddingHorizontal = getValueForScreenType<double>(
          context: context,
          mobile: 20.0,
          tablet: 32.0,
          desktop: 64.0,
        );

        return Container(
          color: backgroundColor,
          decoration: decoration,
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: verticalPadding,
          ),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
