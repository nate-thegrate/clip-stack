import 'package:clip_stack/fonts.dart';
import 'package:clip_stack/navigator.dart';
import 'package:flutter/material.dart';

class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor(this.text, {super.key});
  final String text;

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  late final controller = TextEditingController(text: widget.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => navigator.pop(controller.text),
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: TextField(
          controller: controller,
          maxLines: null,
          style: const Roboto(),
          decoration:
              InputDecoration(border: MaterialStateOutlineInputBorder.resolveWith((states) {
            return OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: states.contains(MaterialState.focused)
                  ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
                  : BorderSide.none,
            );
          })),
        ),
      ),
    );
  }
}
