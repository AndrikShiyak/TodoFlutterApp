import 'package:flutter/material.dart';

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({
    Key? key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.padding,
    this.actions,
    this.appBarsBottom,
  }) : super(key: key);

  final String title;
  final PreferredSizeWidget? appBarsBottom;
  final Widget body;
  final Widget? floatingActionButton;
  final EdgeInsets? padding;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        bottom: appBarsBottom,
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
