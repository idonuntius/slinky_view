import 'package:flutter/material.dart';
import 'package:slinky_view/slinky_view.dart';

typedef OnPointerUp = void Function();

/// SlinkyPanel is a scrollable panel.
class SlinkyPanel extends StatefulWidget {
  const SlinkyPanel({
    super.key,
    required this.panelParameter,
    required this.scrollAnimationParameter,
    required this.onPointerUp,
    required this.controller,
    required this.scrollToTopStream,
  });

  /// SlinkyPannelParameter is a class that handles panel parameters.
  final SlinkyPanelParameter panelParameter;

  /// SlinkyScrollParameter is a class that scroll animation parameters.
  final SlinkyScrollParameter scrollAnimationParameter;

  /// Called when a pointer is no longer in contact with the screen.
  final OnPointerUp onPointerUp;

  ///  A controller that can be used to programmatically control this panel.
  final SlinkyController controller;

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
        duration: widget.scrollAnimationParameter.duration,
        curve: widget.scrollAnimationParameter.curve,
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
          maxChildSize: widget.panelParameter.maxSize,
          minChildSize: widget.panelParameter.minSize,
          initialChildSize: widget.panelParameter.minSize,
          builder: (context, scrollController) {
            _scrollController = scrollController;
            return ClipRRect(
              borderRadius: widget.panelParameter.borderRadius,
              child: CustomScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  widget.panelParameter.appBar,
                  ...widget.panelParameter.contents,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
