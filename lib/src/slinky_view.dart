import 'package:flutter/material.dart';
import 'package:slinky_view/slinky_view.dart';
import 'package:slinky_view/src/slinky_pannel_app_bar.dart';
import 'package:slinky_view/src/slinky_view_state.dart';

/// A container for a DraggableScrollableSheet that responds to drag gestures by resizing
/// the scrollable until a limit is reached, and then scrolling.
/// The body is masked and cannot be manipulated when scrolling upward.
class SlinkyView extends StatefulWidget {
  const SlinkyView({
    super.key,
    required this.panelContents,
    required this.body,
    required this.controller,
    this.panelBar = slinkyPannelAppBar,
    this.panelMaxSize = 0.9,
    this.panelMinSize = 0.4,
    this.panelBorderRadius = const BorderRadius.all(Radius.circular(32)),
    this.scrollTolerance = 0.1,
    this.maskColor = const Color(0x99000000),
  })  : assert(panelMinSize >= 0.0),
        assert(panelMaxSize <= 1.0),
        assert(panelMaxSize > panelMinSize),
        assert(panelMinSize + scrollTolerance < panelMaxSize);

  /// The widget displayed at the top in the Panel.
  /// Thi widget must be SliverAppBar
  final SliverAppBar panelBar;

  /// The widget's displayed in the Panel.
  /// The widget's must be SliverMultiBoxAdaptorWidget
  /// (SliverList, SliverGrid, SliverFixedExtentList, etc.).
  final List<Widget> panelContents;

  /// The maximum fractional value of the panel height to use when displaying the panel.
  /// The default value is `0.9`.
  final double panelMaxSize;

  /// The minimum fractional value of the panel height to use when displaying the panel.
  /// The default value is `0.5`.
  final double panelMinSize;

  /// The rounded corners of panel.
  final BorderRadiusGeometry panelBorderRadius;

  /// Scroll amount tolerance.
  final double scrollTolerance;

  /// The body is displayed below the panel.
  final Widget body;

  /// The maskColor is the color of MaskView.
  /// MaskView is a Widget that is displayed between the panel and
  ///  backgroundContent when the panel is scrolled.
  final Color maskColor;

  /// A controller that can be used to programmatically control panel.
  final SlinkyController controller;

  @override
  SlinkyViewState createState() => SlinkyViewState();
}
