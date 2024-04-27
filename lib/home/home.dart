import 'package:clip_stack/home/clip_fields.dart';
import 'package:clip_stack/home/clip_item.dart';
import 'package:clip_stack/home/markdown_editor.dart';
import 'package:clip_stack/navigator.dart';
import 'package:clip_stack/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

const template = [
  ClipHeader(label: 'dice syntax', value: 4),
  ClipItem(label: 'roll', value: '/roll rolls:', compact: true),
  ClipItem(label: 'adv', value: '2d20/kh', compact: true),
  ClipItem(label: 'disadv', value: '2d20/kl', compact: true),
  ClipHeader(label: 'mods', value: 4),
  ClipItem(label: ' str', value: '+0', compact: true),
  ClipItem(label: ' dex', value: '+0', compact: true),
  ClipItem(label: ' con', value: '+3', compact: true),
  ClipItem(label: ' int', value: '+4', compact: true),
  ClipItem(label: ' wis', value: '+2', compact: true),
  ClipItem(label: ' cha', value: '-1', compact: true),
  ClipItem(label: ' prof', value: '+2', compact: true),
  ClipItem(label: ' expertise', value: '+4', compact: true),
  ClipHeader(label: 'Combat', value: 2),
  ClipItem(label: 'initiative', value: 'roll d20 dex'),
  ClipItem(label: 'spell attack roll', value: 'roll d20 int prof'),
  ClipHeader(label: 'Skills', value: 2),
  ClipHeader(label: 'Strength', value: 5),
  ClipItem(label: 'Athletics', value: 'roll d20 str', compact: true),
  ClipHeader(label: 'Dexterity', value: 5),
  ClipItem(label: 'Acrobatics, Sleight of Hand, Stealth', value: 'roll d20 dex', compact: true),
  ClipHeader(label: 'Intelligence', value: 5),
  ClipItem(label: 'History (stonework)', value: 'roll d20 int expertise', compact: true),
  ClipItem(label: 'History, Nature', value: 'roll d20 int', compact: true),
  ClipItem(label: 'Arcana, Religion', value: 'roll d20 int prof', compact: true),
  ClipItem(label: 'Investigation', value: 'roll d20+d4 int prof', compact: true),
  ClipHeader(label: 'Wisdom', value: 5),
  ClipItem(label: 'Insight', value: 'roll d20 wis prof', compact: true),
  ClipItem(label: 'Everything Else', value: 'roll d20 wis', compact: true),
  ClipHeader(label: 'Charisma', value: 5),
  ClipItem(label: 'Intimidation', value: 'roll d20 cha prof', compact: true),
  ClipItem(label: 'Everything Else', value: 'roll d20 cha', compact: true),
];

class _HomePageState extends State<HomePage> {
  bool textEnabled = false;
  ClipstackItems clipItems = ClipstackItems(template);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (!markdownEditing) {
                context.read<Editing>().toggle();
                return;
              }
              final newMarkdown = navigator.push<String>(MarkdownEditor(clipItems.markdown));
              if (await newMarkdown case final markdown?) {
                setState(() => clipItems = ClipstackItems.fromMarkdown(markdown));
              }
            },
            icon: Icon(context.watch<Editing>().value ? Icons.done : Icons.edit),
          ),
          IconButton(
            onPressed: () => navigator.push(const SettingsScreen()),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ClipFields(items: ClipstackItems(template)),
    );
  }
}

class Editing extends ValueNotifier<bool> {
  Editing() : super(false);

  void toggle() => value = !value;
}
