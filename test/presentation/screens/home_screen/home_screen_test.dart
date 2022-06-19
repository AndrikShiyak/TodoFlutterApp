import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/presentation/screens/create_todo_screen/create_todo_screen.dart';
import 'package:todo_app/presentation/screens/home_screen/home_screen.dart';
import 'package:todo_app/presentation/screens/home_screen/widgets/todos_list.dart';
import 'package:todo_app/presentation/shared/main_app_bar.dart';

import '../../../helpers/test_helper.dart';
import '../../../mocks/navigator_observer.mocks.dart';

void main() async {
  group('Home Screen', () {
    late final MockNavigatorObserver mockObserver;

    setUpAll(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets(
      'Home screen should have appBar with title: Home Screen and todosList and Floating action button',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          TestsHelper.parentWidget(
            HomeScreen(title: 'Home Screen'),
            // mockObserver,
          ),
        );

        final appBarFinder = find.byType(MainAppBar);

        final titleFinder = find.text('Home Screen');

        final todosListFinder = find.byType(TodosList);

        final fabFinder = find.byType(FloatingActionButton);

        // Check if there is appBar
        expect(appBarFinder, findsOneWidget);
        // Check if there is title
        expect(titleFinder, findsOneWidget);
        // Check if there is List with Todos
        expect(todosListFinder, findsOneWidget);
        // Check if there is Floating Action Button
        expect(fabFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Whe floating action button is pressed, CreateTodo screen should be pushed",
      (WidgetTester tester) async {
        await tester.pumpWidget(
          TestsHelper.parentWidget(
            HomeScreen(title: 'Home Screen'),
            mockObserver,
          ),
        );

        final fabFinder = find.byType(FloatingActionButton);

        await tester.tap(fabFinder);
        await tester.pumpAndSettle();

        /// Verify that a push event happened
        verify(mockObserver.didPush(any, any));

        expect(find.byType(CreateTodoScreen), findsOneWidget);
      },
    );
  });
}
