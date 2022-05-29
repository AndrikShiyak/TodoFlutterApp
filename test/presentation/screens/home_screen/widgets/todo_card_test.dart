import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/presentation/screens/home_screen/widgets/todo_card.dart';

void main() {
  testWidgets('Todo Card should have title', (WidgetTester tester) async {
    final String testTitle = 'Test Title';
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, widget) => MaterialApp(
          home: Scaffold(
            body: TodoCard(
              title: testTitle,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    final title = find.text(testTitle);

    expect(title, findsOneWidget);
  });
}
