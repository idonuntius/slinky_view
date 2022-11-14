import 'package:flutter/material.dart';

/// Default app bar.
const slinkyPanelAppBar = SliverAppBar(
  elevation: 0,
  title: SizedBox(
    width: 56,
    height: 5,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
        color: Colors.grey,
      ),
    ),
  ),
  automaticallyImplyLeading: false,
  backgroundColor: Colors.white,
  primary: false,
  floating: true,
  pinned: true,
);
