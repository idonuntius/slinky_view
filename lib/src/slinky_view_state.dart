import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slinky_view/slinky_view.dart';
import 'package:slinky_view/src/mask_view.dart';
import 'package:slinky_view/src/slinky_panel.dart';

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
