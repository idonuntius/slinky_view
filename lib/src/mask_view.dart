import 'package:flutter/material.dart';

/// MaskView is a Widget that is displayed between the panel and the body when the panel is scrolled.
class MaskView extends StatelessWidget {
  const MaskView({
    super.key,
    required this.colorStream,
    required this.onTap,
    required this.barrierDismissible,
  });

  /// Stream to change the color of mask view.
  final Stream<Color> colorStream;

  /// Called when the user taps this mask view.
  final VoidCallback onTap;

  /// The barrierDismissible argument is used to indicate whether tapping on the barrier will scroll down the panel.
  final bool barrierDismissible;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Color>(
      initialData: Colors.transparent,
      stream: colorStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.opacity == 0) {
          return const SizedBox.shrink();
        } else {
          return IgnorePointer(
            ignoring: !barrierDismissible,
            child: GestureDetector(
              onTap: onTap,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ColoredBox(color: snapshot.data!),
              ),
            ),
          );
        }
      },
    );
  }
}
