import 'package:flutter/material.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.padding,
  }) : super(key: key);

  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
