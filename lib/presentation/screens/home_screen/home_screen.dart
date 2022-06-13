import 'package:flutter/material.dart';
import 'package:todo_app/logic/cubit/todos_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';
import 'package:todo_app/presentation/screens/home_screen/widgets/todo_card.dart';
import 'package:todo_app/presentation/shared/main_page_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final todosList =
        context.select((TodosCubit cubit) => cubit.state.todosList);

    return MainPageLayout(
      title: 'Home Screen',
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemBuilder: (context, index) => Dismissible(
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
            // TODO implement delete

            if (direction.name == 'endToStart') {
              print('delete');
            } else {
              print('else');
            }
          },
          confirmDismiss: (direction) async {
            if (direction.name == 'endToStart') {
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
            }
          },
          key: UniqueKey(),
          child: TodoCard(
            // TODO remove ?? null
            title: todosList[index].title ?? 'null',
            onTap: () {
              context.read<TodosCubit>().selectTodo(todosList[index]);
              Navigator.of(context).pushNamed(AppRouter.todo);
            },
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: todosList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRouter.createTodo),
        child: Icon(Icons.add),
      ),
    );
  }
}
