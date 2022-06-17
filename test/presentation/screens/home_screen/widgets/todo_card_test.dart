import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/data/models/sub_todo_model.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/screens/home_screen/widgets/todo_card.dart';

void main() {
  group(
    'Todo Card',
    () {
      Widget parentWidget(Widget child) {
        return ScreenUtilInit(
          designSize: const Size(375, 667),
          builder: (context, widget) => MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: child,
              ),
            ),
          ),
        );
      }

      testWidgets(
          'Todo Card should have title, rounded borders, color white and shadows',
          (WidgetTester tester) async {
        final TodoModel testTodo = TodoModel(
          id: '123',
          title: 'Test Title',
          subTodos: [],
        );
        await tester.pumpWidget(
          parentWidget(
            TodoCard(
              todo: testTodo,
              onTap: () {},
              onDismissed: () {},
            ),
          ),
        );

        final title = find.text(testTodo.title);
        final boxDecoration = (tester
            .firstWidget<Container>(find.byType(Container))
            .decoration as BoxDecoration);
        final color = boxDecoration.color;
        final borderRadius = boxDecoration.borderRadius;
        final boxShadow = boxDecoration.boxShadow;

        expect(title, findsOneWidget);
        expect(color, Colors.white);
        expect(borderRadius, BorderRadius.circular(5.r));
        expect(boxShadow?.length, 1);
        expect(boxShadow?[0].offset, Offset(1.r, 1.r));
        expect(boxShadow?[0].color, Colors.grey.shade300);
        expect(boxShadow?[0].blurRadius, 4.r);
        expect(boxShadow?[0].spreadRadius, 2.r);
      });

      testWidgets(
        'Test title',
        (WidgetTester tester) async {
          final TodoModel testTodo = TodoModel(
            id: '123',
            title: 'Test Title',
            subTodos: [
              SubTodoModel(id: '111', title: 'test subtodo', isDone: true),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: false),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: false),
            ],
          );
          await tester.pumpWidget(
            parentWidget(
              TodoCard(
                todo: testTodo,
                onTap: () {},
                onDismissed: () {},
              ),
            ),
          );

          final text = find.byType(Text);
          final shadows = tester.firstWidget<Text>(text).style?.shadows;

          expect(tester.firstWidget<Text>(text).style?.fontSize, 20.sp);
          expect(tester.firstWidget<Text>(text).style?.fontWeight,
              FontWeight.w500);
          expect(shadows?.length, 1);
          expect(shadows?[0].color, Colors.black);
          expect(shadows?[0].blurRadius, 0.0);
          expect(shadows?[0].offset, Offset(1.5.w, 1.5.w));
        },
      );

      group('Test width and color of green progress container', () {
        testWidgets(
            'Width should be 1/3 of TodoCard width and color = Colors.green with (0.2 + 0.8/3) opacity',
            (WidgetTester tester) async {
          final TodoModel testTodo = TodoModel(
            id: '123',
            title: 'Test Title',
            subTodos: [
              SubTodoModel(id: '111', title: 'test subtodo', isDone: true),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: false),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: false),
            ],
          );
          await tester.pumpWidget(
            parentWidget(
              TodoCard(
                todo: testTodo,
                onTap: () {},
                onDismissed: () {},
              ),
            ),
          );

          // final card = find.byType(TodoCard);
          final greenContainer = find.byKey(Key('greenContainer'));
          final cardSize = tester.getSize(find.byType(TodoCard));
          final progressContainerSize = tester.getSize(greenContainer);
          final borderRadius = (tester
                  .firstWidget<Container>(greenContainer)
                  .decoration as BoxDecoration)
              .borderRadius;

          expect(progressContainerSize.width, cardSize.width / 3);
          expect(
              (tester.firstWidget<Container>(greenContainer).decoration
                      as BoxDecoration)
                  .color,
              Colors.green.withOpacity(0.2 + 0.8 / 3));
          expect(borderRadius, BorderRadius.circular(5.r));
        });

        testWidgets(
            'Width should be 2/3 of TodoCard width and color = Colors.green with (0.2 + 0.8/3 * 2) opacity',
            (WidgetTester tester) async {
          final TodoModel testTodo = TodoModel(
            id: '123',
            title: 'Test Title',
            subTodos: [
              SubTodoModel(id: '111', title: 'test subtodo', isDone: true),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: true),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: false),
            ],
          );
          await tester.pumpWidget(
            parentWidget(
              TodoCard(
                todo: testTodo,
                onTap: () {},
                onDismissed: () {},
              ),
            ),
          );

          final greenContainer = find.byKey(Key('greenContainer'));
          final cardSize = tester.getSize(find.byType(TodoCard));
          final progressContainerSize = tester.getSize(greenContainer);

          expect(progressContainerSize.width, (cardSize.width / 3) * 2);
          expect(
              (tester.firstWidget<Container>(greenContainer).decoration
                      as BoxDecoration)
                  .color,
              Colors.green.withOpacity(0.2 + 0.8 / 3 * 2));
        });

        testWidgets(
            'Width should be same as TodoCard width and color = Colors.green with 1.0 opacity',
            (WidgetTester tester) async {
          final TodoModel testTodo = TodoModel(
            id: '123',
            title: 'Test Title',
            subTodos: [
              SubTodoModel(id: '111', title: 'test subtodo', isDone: true),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: true),
              SubTodoModel(id: '222', title: 'test subtodo2', isDone: true),
            ],
          );
          await tester.pumpWidget(
            parentWidget(
              TodoCard(
                todo: testTodo,
                onTap: () {},
                onDismissed: () {},
              ),
            ),
          );

          final greenContainer = find.byKey(Key('greenContainer'));
          final cardSize = tester.getSize(find.byType(TodoCard));
          final progressContainerSize = tester.getSize(greenContainer);

          expect(progressContainerSize.width, cardSize.width);
          expect(
              (tester.firstWidget<Container>(greenContainer).decoration
                      as BoxDecoration)
                  .color,
              Colors.green.withOpacity(1));
        });
      });
    },
  );
}
