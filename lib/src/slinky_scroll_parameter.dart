import 'package:flutter/material.dart';

/// SlinkyScrollParameter is a class that scroll animation parameters.
class SlinkyScrollParameter {
  const SlinkyScrollParameter({
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
    this.scrollTolerance = 0.1,
  });

  /// Scrolling time.
  final Duration duration;

  /// Animation curves.
  final Curve curve;

  /// Scroll amount tolerance.
  final double scrollTolerance;

  /// Creates a copy of this SlinkyScrollAnimationParameter but with the given fields replaced with the new values.
  SlinkyScrollParameter copyWith({
    Duration? duration,
    Curve? curve,
  }) {
    return SlinkyScrollParameter(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}
