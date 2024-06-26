import 'package:clip_stack/fonts.dart';
import 'package:clip_stack/home/clip_item.dart';
import 'package:clip_stack/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipField extends StatelessWidget {
  const ClipField(this.item, {required this.onTap, super.key});

  final ClipItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ClipItem(:label, :value, :compact) = item;

    final children = [
      if (label != null)
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(label, softWrap: false),
        ),
      Expanded(
        child: Opacity(
          opacity: 2 / 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Text(value, style: const Roboto(), softWrap: false, overflow: TextOverflow.fade),
          ),
        ),
      ),
    ];

    return SizedBox(
      width: double.infinity,
      height: compact ? 25 : 60,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Row(children: children),
        ),
      ),
    );
  }
}

class ClipFieldHeader extends StatelessWidget {
  const ClipFieldHeader(this.header, {super.key});

  final ClipHeader header;

  @override
  Widget build(BuildContext context) {
    final ClipHeader(:label, :value) = header;

    final textTheme = Theme.of(context).textTheme;
    final (padding, style) = switch (value) {
      1 => (10.0, textTheme.headlineLarge!),
      2 => (8.00, textTheme.headlineMedium!),
      3 => (6.00, textTheme.headlineSmall!),
      4 => (4.00, textTheme.titleLarge!),
      5 => (2.00, textTheme.titleMedium!),
      _ => (0.00, textTheme.titleSmall!),
    };

    return Padding(
      padding: EdgeInsets.fromLTRB(16, (padding + 4) * 4, 0, padding),
      child: Text(label, style: style),
    );
  }
}

class ClipFields extends StatefulWidget {
  const ClipFields({required this.items, super.key});
  final List<ClipstackItem> items;

  @override
  State<ClipFields> createState() => _ClipFieldsState();
}

class _ClipFieldsState extends State<ClipFields> {
  void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    navigator.showSnackBar(const SnackBar(content: Text('copied!')));
  }

  bool addD4 = false;
  @override
  Widget build(BuildContext context) {
    final d4 = ClipItem(label: 'd20 ', value: addD4 ? 'd20+d4 ' : ' d20 ', compact: true);
    late final items = ClipstackItems(widget.items.toList()..insert(4, d4));
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('add extra d4'),
          value: addD4,
          onChanged: (_) => setState(() => addD4 = !addD4),
        ),
        for (final (i, item) in items.indexed)
          switch (item) {
            final ClipItem item => ClipField(item, onTap: () => copy(items.clipboardValue(i))),
            final ClipHeader header => ClipFieldHeader(header),
          },
        const SizedBox(height: 120),
      ],
    );
  }
}
