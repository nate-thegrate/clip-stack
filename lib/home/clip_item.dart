import 'package:clip_stack/home/home.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ClipstackItem {
  const ClipstackItem();

  factory ClipstackItem.fromJson(Map<String, dynamic> json) {
    return switch ((json['label'], json['value'])) {
      (final String label, final int value) => ClipHeader(label: label, value: value),
      (final String? label, final String value) => ClipItem(label: label, value: value),
      (final a, final b) => throw Exception("unable to parse {'label': $a, 'value': $b}"),
    };
  }

  Map<String, dynamic> get json;
  String get markdown;
}

class ClipHeader implements ClipstackItem {
  const ClipHeader({required this.label, required this.value}) : assert(value >= 1 && value <= 6);

  final String label;
  final int value;

  @override
  Map<String, dynamic> get json => {'label': label, 'value': value};
  @override
  String get markdown {
    final hashtags = '#' * value;
    final pre = value == 1 ? '\n\n' : '\n';
    final post = value < 4 ? '\n' : '';
    return '$pre$hashtags $label$post';
  }

  @override
  bool operator ==(Object other) =>
      other is ClipHeader && other.label == label && other.value == value;
  @override
  int get hashCode => Object.hash(label.hashCode, value.hashCode);
}

class ClipItem implements ClipstackItem {
  const ClipItem({required this.label, required this.value, this.compact = false});

  final String? label;
  final String value;
  final bool compact;

  @override
  Map<String, dynamic> get json => {
        if (label != null) 'label': label,
        'value': value,
        if (compact) 'compact': true,
      };

  @override
  String get markdown {
    String label = switch (this.label) {
      null => '',
      final s when s != s.trim() || {'#', '`'}.any(s.contains) => '"$s"',
      final s => s,
    };
    label = compact ? '- $label: ' : '\n$label';

    String mdValue(int tickCount) {
      final ticks = '`' * tickCount;
      if (value.contains(ticks)) return mdValue(tickCount + 1);
      String val = value;
      if (compact) {
        if (val.startsWith('`')) val = ' $val';
        if (val.endsWith('`')) val = '$val ';
      }
      return ['', ticks, val, ticks].join(compact ? '' : '\n');
    }

    return label + mdValue(compact ? 1 : 3);
  }

  @override
  bool operator ==(Object other) =>
      other is ClipItem && other.label == label && other.value == value;
  @override
  int get hashCode => Object.hash(label.hashCode, value.hashCode, compact.hashCode);
}

extension type ClipstackItems(List<ClipstackItem> data) implements List<ClipstackItem> {
  factory ClipstackItems.fromMarkdown(String markdown) {
    return ClipstackItems(template);
  }

  String clipboardValue(int index) {
    var ClipItem(value: string) = data[index] as ClipItem;
    for (int i = 0; i < index; i++) {
      if (data[i] case ClipItem(:final label?, :final value)) {
        string = string.replaceAll(label, value);
      }
    }
    return string;
  }

  String get markdown => [for (final item in data) item.markdown].join('\n');
}
