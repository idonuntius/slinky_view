import 'package:flutter/material.dart';
import 'package:slinky_view/src/slinky_panel_app_bar.dart';

/// SlinkyPannelParameter is a class that handles panel parameters.
class SlinkyPanelParameter {
  const SlinkyPanelParameter({
    required this.contents,
    this.appBar = slinkyPanelAppBar,
    this.maxSize = 0.9,
    this.minSize = 0.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
  })  : assert(minSize >= 0.0),
        assert(maxSize <= 1.0),
        assert(maxSize > minSize);

  /// The widget displayed at the top in the Panel.
  final SliverAppBar appBar;

  /// The widget's displayed in the Panel.
  /// The widget's must be Sliver widgets.
  final List<Widget> contents;

  /// The maximum fractional value of the panel height to use when displaying the panel.
  /// The default value is `0.9`.
  final double maxSize;

  /// The minimum fractional value of the panel height to use when displaying the panel.
  /// The default value is `0.4`.
  final double minSize;

  /// The rounded corners of panel.
  final BorderRadiusGeometry borderRadius;

  /// Creates a copy of this SlinkyPanelParameter but with the given fields replaced with the new values.
  SlinkyPanelParameter copyWith({
    SliverAppBar? appBar,
    List<Widget>? contents,
    double? maxSize,
    double? minSize,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SlinkyPanelParameter(
      appBar: appBar ?? this.appBar,
      contents: contents ?? this.contents,
      maxSize: maxSize ?? this.maxSize,
      minSize: minSize ?? this.minSize,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
