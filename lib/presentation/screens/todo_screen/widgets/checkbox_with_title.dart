import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckboxWithTitle extends StatelessWidget {
  const CheckboxWithTitle({
    Key? key,
    required this.title,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  final bool value;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: (_) => onTap()),
        SizedBox(width: 20.w),
        Text(title),
      ],
    );
  }
}
