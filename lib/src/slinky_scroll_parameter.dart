import 'package:flutter/material.dart';

/// SlinkyScrollParameter is a class that scroll animation parameters.
class SlinkyScrollParameter {
  const SlinkyScrollParameter({
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.linear,
    this.scrollTolerance = 0.1,
  }) : assert(scrollTolerance >= 0.0 && scrollTolerance < 1.0);

  /// Scrolling time.
  /// The default value is `Duration(milliseconds: 100)`.
  final Duration duration;

  /// Animation curves.
  /// The default value is `Curves.linear`.
  final Curve curve;

  /// Scroll amount tolerance.
  /// The default value is `0.1`.
  final double scrollTolerance;

  /// Creates a copy of this SlinkyScrollAnimationParameter but with the given fields replaced with the new values.
  SlinkyScrollParameter copyWith({
    Duration? duration,
    Curve? curve,
    double? scrollTolerance,
  }) {
    return SlinkyScrollParameter(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      scrollTolerance: scrollTolerance ?? this.scrollTolerance,
    );
  }
}
