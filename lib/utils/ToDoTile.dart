import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  String taskName;
  bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext?)? deleteFunction;

 ToDoTile({
    required this.taskName,
   required this.taskCompleted,
   required this.onChanged,
   required this.deleteFunction,
});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:
    EdgeInsets.fromLTRB(25,25,25, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: deleteFunction,
            icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.yellow,
        borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Checkbox(value: taskCompleted, onChanged: onChanged,
            activeColor: Colors.black,
            ),
            Text(taskName,style: TextStyle(
              decoration: taskCompleted ?
                  TextDecoration.lineThrough:
                  TextDecoration.none
            ),)
          ]),
        ),
      ),
    );
  }
}
