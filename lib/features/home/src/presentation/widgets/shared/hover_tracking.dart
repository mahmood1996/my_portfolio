import 'package:flutter/material.dart';

final class HoverTracking extends StatefulWidget {
  const HoverTracking({super.key, required this._builder});

  final Widget Function(BuildContext context, bool isHovered) _builder;

  @override
  State<HoverTracking> createState() => _HoverTrackingState();
}

final class _HoverTrackingState extends State<HoverTracking>
    with AutomaticKeepAliveClientMixin {
  final _collectedHovers = [false];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MouseRegion(
      onHover: (_) => setState(() => _collectedHovers.first = true),
      onExit: (_) => setState(() => _collectedHovers.first = false),
      child: widget._builder(context, _collectedHovers.first),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
