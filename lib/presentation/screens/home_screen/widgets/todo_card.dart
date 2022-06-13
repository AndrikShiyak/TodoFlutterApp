import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/data/models/todo_model.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    required this.onTap,
    required this.onDismissed,
    required this.todo,
  });

  final VoidCallback onTap;
  final VoidCallback onDismissed;
  final TodoModel todo;

  late final double percentageOfDoneSubtodos =
      todo.subTodos.where((element) => element.isDone).isNotEmpty
          ? (todo.subTodos.where((element) => element.isDone).length /
              todo.subTodos.length)
          : 0;

  @override
  Widget build(BuildContext context) {
    final double greenContainerWidth =
        (MediaQuery.of(context).size.width - 40.w) * percentageOfDoneSubtodos;

    final double greenContainerColorOpacity =
        0.2 + 0.8 * percentageOfDoneSubtodos;

    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5.w),
          ),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) {
          if (direction.name == 'endToStart') {
            onDismissed();
          }
        },
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('title'),
              content: Text('content'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes')),
              ],
            ),
          );
        },
        key: UniqueKey(),
        child: Container(
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                offset: Offset(1.r, 1.r),
                color: Colors.grey.shade300,
                blurRadius: 4.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: greenContainerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color:
                          Colors.green.withOpacity(greenContainerColorOpacity),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Text(
                todo.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
