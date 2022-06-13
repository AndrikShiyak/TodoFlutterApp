import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    required this.title,
    required this.onTap,
    required this.onDismissed,
  });

  final String title;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
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
                    width: 140.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
