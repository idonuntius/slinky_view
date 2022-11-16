import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slinky_view/slinky_view.dart';
import 'package:slinky_view/src/mask_view.dart';
import 'package:slinky_view/src/slinky_panel.dart';

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
    this.barrierDismissible = true,
  });

  /// SlinkyPannelParameter is a class that handles panel parameters.
  final SlinkyPanelParameter panelParameter;

  /// The body is displayed below the panel.
  final Widget body;

  /// The maskColor is the color of MaskView.
  /// MaskView is a Widget that is displayed between the panel and
  /// body when the panel is scrolled.
  final Color maskColor;

  /// The barrierDismissible argument is used to indicate whether tapping on the barrier will scroll down the panel.
  final bool barrierDismissible;

  /// SlinkyScrollParameter is a class that scroll animation parameters.
  final SlinkyScrollParameter scrollParameter;

  /// A controller that can be used to programmatically control panel.
  final SlinkyController controller;

  @override
  SlinkyViewState createState() => SlinkyViewState();
}

class SlinkyViewState extends State<SlinkyView> {
  final _maskColorController = StreamController<Color>();
  final _scrollToTopController = StreamController<void>();
  late double _currentPanelSize;

  @override
  void initState() {
    super.initState();
    _currentPanelSize = widget.panelParameter.minSize;
    widget.controller.addListener(_onScrolled);
  }

  @override
  void dispose() {
    _maskColorController.close();
    _scrollToTopController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        MaskView(
          colorStream: _maskColorController.stream,
          onTap: () {
            _scroll(widget.panelParameter.minSize);
            _scrollToTopController.sink.add(null);
          },
          barrierDismissible: widget.barrierDismissible,
        ),
        SlinkyPanel(
          panelParameter: widget.panelParameter,
          scrollAnimationParameter: widget.scrollParameter,
          onPointerUp: () => _onPointerUp(),
          controller: widget.controller,
          scrollToTopStream: _scrollToTopController.stream,
        ),
      ],
    );
  }

  void _onPointerUp() {
    final double size;
    if (_currentPanelSize == widget.panelParameter.minSize) {
      if (widget.controller.size >=
          widget.panelParameter.minSize +
              widget.scrollParameter.scrollTolerance) {
        size = widget.panelParameter.maxSize;
      } else {
        size = widget.panelParameter.minSize;
      }
    } else {
      if (widget.controller.size <=
          widget.panelParameter.maxSize -
              widget.scrollParameter.scrollTolerance) {
        size = widget.panelParameter.minSize;
      } else {
        size = widget.panelParameter.maxSize;
      }
    }
    _scroll(size);
  }

  void _onScrolled() {
    _changeCurrentPanelSize();
    _changeMaskColor();
  }

  void _changeCurrentPanelSize() {
    if (_currentPanelSize == widget.panelParameter.minSize &&
        widget.controller.size == widget.panelParameter.maxSize) {
      _currentPanelSize = widget.panelParameter.maxSize;
    } else if (_currentPanelSize == widget.panelParameter.maxSize &&
        widget.controller.size == widget.panelParameter.minSize) {
      _currentPanelSize = widget.panelParameter.minSize;
    }
  }

  void _changeMaskColor() {
    final opacitiyOfOverlay = widget.maskColor.opacity;
    final result = opacitiyOfOverlay *
        (widget.controller.size - widget.panelParameter.minSize) /
        (widget.panelParameter.maxSize - widget.panelParameter.minSize);
    _maskColorController.sink.add(widget.maskColor.withOpacity(result));
  }

  void _scroll(double position) {
    widget.controller.animateTo(
      position,
      duration: widget.scrollParameter.duration,
      curve: widget.scrollParameter.curve,
    );
  }
}
