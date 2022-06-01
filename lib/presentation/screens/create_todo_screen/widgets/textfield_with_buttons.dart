import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/widgets/icon_button_w.dart';

class TextFieldWithButtons extends StatefulWidget {
  const TextFieldWithButtons({
    Key? key,
    this.onChange,
    this.delete,
  }) : super(key: key);

  final VoidCallback? delete;
  final void Function(String value)? onChange;

  @override
  State<TextFieldWithButtons> createState() => _TextFieldWithButtonsState();
}

class _TextFieldWithButtonsState extends State<TextFieldWithButtons> {
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
    if (widget.onChange != null && _controller.text.trim().isNotEmpty) {
      widget.onChange!(_controller.text.trim());
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
