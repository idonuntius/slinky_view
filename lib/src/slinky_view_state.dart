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
    _currentPanelSize = widget.panelMinSize;
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
            _scroll(widget.panelMinSize);
            _scrollToTopController.sink.add(null);
          },
        ),
        SlinkyPanel(
          onPointerUp: () => _onPointerUp(),
          controller: widget.controller,
          maxSize: widget.panelMaxSize,
          minSize: widget.panelMinSize,
          borderRadius: widget.panelBorderRadius,
          panelBar: widget.panelBar,
          panelContents: widget.panelContents,
          scrollToTopStream: _scrollToTopController.stream,
        ),
      ],
    );
  }

  void _onPointerUp() {
    final double size;
    if (_currentPanelSize == widget.panelMinSize) {
      if (widget.controller.size >= widget.panelMinSize + widget.scrollTolerance) {
        size = widget.panelMaxSize;
      } else {
        size = widget.panelMinSize;
      }
    } else {
      if (widget.controller.size <= widget.panelMaxSize - widget.scrollTolerance) {
        size = widget.panelMinSize;
      } else {
        size = widget.panelMaxSize;
      }
    }
    _scroll(size);
  }

  void _onScrolled() {
    _changeCurrentPanelSize();
    _changeMaskColor();
  }

  void _changeCurrentPanelSize() {
    if (_currentPanelSize == widget.panelMinSize && widget.controller.size == widget.panelMaxSize) {
      _currentPanelSize = widget.panelMaxSize;
    } else if (_currentPanelSize == widget.panelMaxSize && widget.controller.size == widget.panelMinSize) {
      _currentPanelSize = widget.panelMinSize;
    }
  }

  void _changeMaskColor() {
    final opacitiyOfOverlay = widget.maskColor.opacity;
    final result = opacitiyOfOverlay *
        (widget.controller.size - widget.panelMinSize) /
        (widget.panelMaxSize - widget.panelMinSize);
    _maskColorController.sink.add(widget.maskColor.withOpacity(result));
  }

  void _scroll(double position) {
    widget.controller.animateTo(
      position,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}
