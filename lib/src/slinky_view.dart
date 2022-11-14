import 'package:flutter/material.dart';
import 'package:slinky_view/slinky_view.dart';
import 'package:slinky_view/src/slinky_view_state.dart';

/// A container for a DraggableScrollableSheet that responds to drag gestures by resizing
/// the scrollable until a limit is reached, and then scrolling.
/// The body is masked and cannot be manipulated when scrolling upward.
class SlinkyView extends StatefulWidget {
  const SlinkyView({
    super.key,
    required this.panelParameter,
    required this.body,
    required this.controller,
    this.scrollParameter = const SlinkyScrollParameter(),
    this.maskColor = const Color(0x99000000),
  });

  /// SlinkyPannelParameter is a class that handles panel parameters.
  final SlinkyPanelParameter panelParameter;

  /// The body is displayed below the panel.
  final Widget body;

  /// The maskColor is the color of MaskView.
  /// MaskView is a Widget that is displayed between the panel and
  ///  backgroundContent when the panel is scrolled.
  final Color maskColor;

  /// SlinkyScrollParameter is a class that scroll animation parameters.
  final SlinkyScrollParameter scrollParameter;

  /// A controller that can be used to programmatically control panel.
  final SlinkyController controller;

  @override
  SlinkyViewState createState() => SlinkyViewState();
}
