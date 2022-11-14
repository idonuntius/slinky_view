import 'package:flutter/material.dart';
import 'package:slinky_view/slinky_view.dart';

typedef OnPointerUp = void Function();

class SlinkyPanel extends StatefulWidget {
  const SlinkyPanel({
    super.key,
    required this.onPointerUp,
    required this.controller,
    required this.maxSize,
    required this.minSize,
    required this.borderRadius,
    required this.panelBar,
    required this.panelContents,
    required this.scrollToTopStream,
  }) : assert(panelBar is SliverAppBar);

  /// Called when a pointer is no longer in contact with the screen.
  final OnPointerUp onPointerUp;

  ///  A controller that can be used to programmatically control this panel.
  final SlinkyController controller;

  /// The maximum fractional value of the panel height to use when displaying the panel.
  /// The default value is `0.9`.
  final double maxSize;

  /// The minimum fractional value of the panel height to use when displaying the panel.
  /// The default value is `0.5`.
  final double minSize;

  /// The rounded corners of panel.
  final BorderRadiusGeometry borderRadius;

  /// The widget displayed at the top in the Panel.
  /// The widget must be SliverAppBar
  final Widget panelBar;

  /// The widget's displayed in the Panel.
  /// The widget's must be SliverMultiBoxAdaptorWidget(SliverList, SliverGrid, SliverFixedExtentList, etc.).
  final List<Widget> panelContents;

  /// This Stream is for scrolling to Top.
  final Stream<void> scrollToTopStream;

  @override
  SlinkyPannelState createState() => SlinkyPannelState();
}

class SlinkyPannelState extends State<SlinkyPanel> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    widget.scrollToTopStream.listen((_) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) => widget.onPointerUp(),
      child: SizedBox.expand(
        child: DraggableScrollableSheet(
          controller: widget.controller,
          maxChildSize: widget.maxSize,
          minChildSize: widget.minSize,
          initialChildSize: widget.minSize,
          builder: (context, scrollController) {
            _scrollController = scrollController;
            return ClipRRect(
              borderRadius: widget.borderRadius,
              child: CustomScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  widget.panelBar,
                  ...widget.panelContents,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
