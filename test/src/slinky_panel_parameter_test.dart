import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slinky_view/slinky_view.dart';

void main() {
  group('SlinkyPanelParameter', () {
    group('copyWith', () {
      test('The value must be correct', () {
        var parameter = SlinkyPanelParameter(
          contents: [
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate([const Text('test')]),
            ),
          ],
        );
        parameter = parameter.copyWith(maxSize: 1.0, minSize: 0.0);
        expect(parameter.maxSize, 1.0);
        expect(parameter.minSize, 0.0);
      });
    });
  });
}
