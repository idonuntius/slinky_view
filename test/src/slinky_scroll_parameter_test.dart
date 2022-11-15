import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slinky_view/slinky_view.dart';

void main() {
  group('SlinkyScrollParameter', () {
    group('copyWith', () {
      test('The value must be correct', () {
        var parameter = const SlinkyScrollParameter();
        parameter = parameter.copyWith(
          duration: const Duration(days: 1),
          curve: Curves.bounceIn,
          scrollTolerance: 0.3,
        );
        expect(parameter.duration, const Duration(days: 1));
        expect(parameter.curve, Curves.bounceIn);
        expect(parameter.scrollTolerance, 0.3);
      });
    });
  });
}
