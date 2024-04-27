import 'package:flutter/material.dart';

class Roboto extends TextStyle {
  const Roboto({
    double? size,
    bool italic = false,
    bool extraBold = false,
    this.weight = 500,
    super.inherit,
    super.color,
    super.backgroundColor,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.package,
    super.overflow,
  }) : super(
          fontSize: size,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontFamily: 'roboto mono',
          fontWeight: extraBold ? FontWeight.bold : FontWeight.normal,
        );

  final double weight;

  @override
  List<FontVariation>? get fontVariations => [
        FontVariation('wght', weight),
      ];
}

class Pretendard extends TextStyle {
  const Pretendard({
    double? size,
    bool italic = false,
    bool extraBold = false,
    this.weight = 400,
    super.inherit,
    super.color,
    super.backgroundColor,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.package,
    super.overflow,
  }) : super(
          fontSize: size,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontFamily: 'pretendard',
          fontWeight: extraBold ? FontWeight.bold : FontWeight.normal,
        );

  final double weight;

  @override
  List<FontVariation>? get fontVariations => [
        FontVariation('wght', weight),
        // FontVariation('slnt', weight),
      ];
}
