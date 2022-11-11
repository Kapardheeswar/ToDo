import 'package:hive/hive.dart';

class ToDoDataBase{
  List todolist=[];
  final _mybox=Hive.box("mybox");
  void createintialdata(){
    todolist=[
      ["Press the below plus button",true],
      ["Add some new task",false],
      ["Slide on any of the task to delete",true],
    ];
  }
  void loaddata(){
    todolist=_mybox.get("TODOLIST");
  }
  void updatethedata(){
    _mybox.put("TODOLIST", todolist);
  }
}