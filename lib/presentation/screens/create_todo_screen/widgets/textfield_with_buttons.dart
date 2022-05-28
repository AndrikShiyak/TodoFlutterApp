import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/widgets/icon_button_w.dart';

class TextFieldWithButtons extends StatefulWidget {
  const TextFieldWithButtons({
    Key? key,
    required this.save,
    required this.allowCreateSubTodo,
    this.onChange,
    this.delete,
  }) : super(key: key);

  final VoidCallback save;
  final VoidCallback? delete;
  final void Function(String value)? onChange;
  final bool allowCreateSubTodo;

  @override
  State<TextFieldWithButtons> createState() => _TextFieldWithButtonsState();
}

class _TextFieldWithButtonsState extends State<TextFieldWithButtons> {
  bool _canSave = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(_controllerListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

  void _delete() async {
    if (widget.delete == null) return;

    widget.delete!();
  }

  void _controllerListener() {
    if (widget.onChange != null) {
      widget.onChange!(_controller.text.trim());
    }
    if (_controller.text.trim().isNotEmpty) {
      _canSave = true;
    } else {
      _canSave = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              label: Text('title'),
            ),
          ),
        ),
        IconButtonW(
          icon: Icons.save,
          color: _canSave
              ? widget.allowCreateSubTodo
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary
              : Colors.grey,
          onTap: _canSave
              ? () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _canSave = false;
                  });

                  if (!widget.allowCreateSubTodo) return;
                  widget.save();
                }
              : null,
        ),
        if (widget.delete != null)
          IconButtonW(
            icon: Icons.delete,
            color: Theme.of(context).errorColor,
            onTap: _delete,
          ),
      ],
    );
  }
}
